const report = require('multiple-cucumber-html-reporter');
const fs = require('fs');
const os = require('os');
const { execSync } = require('child_process');

const reportDir = `Reports/TestReports/TestReport_${new Date().toISOString().replace(/[:T.-]/g, "_").split("_Z")[0]}`;

// Ensure the directory exists
if (!fs.existsSync(reportDir)) {
    fs.mkdirSync(reportDir, { recursive: true });
}

// Get npm script command directly from process.env
const getNpmScriptCommand = () => {
    return process.env.npm_lifecycle_script || '';
};

// Extract values from npm script command
const extractValueFromCommand = (command, pattern) => {
    const match = command.match(pattern);
    return match ? match[1] : null;
};

// Get headless mode from npm script
const getHeadlessMode = () => {
    const command = getNpmScriptCommand();
    console.log('NPM Script Command:', command);
    
    // Try to extract HEADLESS value
    const headlessValue = extractValueFromCommand(command, /HEADLESS=(true|false)/i);
    
    if (headlessValue === 'true') {
        return 'Yes';
    } else if (headlessValue === 'false') {
        return 'No';
    } else {
        // Default to No if not specified
        return 'No';
    }
};

// Get environment from npm script
const getEnvironment = () => {
    const command = getNpmScriptCommand();
    const envValue = extractValueFromCommand(command, /Env=(\w+)/i);
    return envValue || 'QA';
};

// Get infrastructure from npm script
const getInfrastructure = () => {
    const command = getNpmScriptCommand();
    const infraValue = extractValueFromCommand(command, /Infra=(\w+)/i);
    return infraValue || 'onPrem';
};

// Get browser from npm script
const getBrowser = () => {
    const command = getNpmScriptCommand();
    const browserValue = extractValueFromCommand(command, /Browser=(\w+(-\w+)?)/i);
    return browserValue || 'chromium';
};

const deviceName = os.hostname();
const executionStartTime = new Date().toLocaleString();
const headlessMode = getHeadlessMode();
const environment = getEnvironment();
const infrastructure = getInfrastructure();
const browser = getBrowser();

// Calculate test duration
const getTestDuration = () => {
    try {
        // Read the cucumber JSON reports to calculate total duration
        const jsonFiles = fs.readdirSync('Reports/').filter(file => file.endsWith('.json'));
        let totalDuration = 0;
        
        jsonFiles.forEach(file => {
            const jsonData = JSON.parse(fs.readFileSync(`Reports/${file}`, 'utf8'));
            jsonData.forEach(feature => {
                if (feature.elements) {
                    feature.elements.forEach(scenario => {
                        if (scenario.steps) {
                            scenario.steps.forEach(step => {
                                if (step.result && step.result.duration) {
                                    totalDuration += step.result.duration;
                                }
                            });
                        }
                    });
                }
            });
        });
        
        // Convert nanoseconds to seconds and format
        const durationInSeconds = totalDuration / 1000000000;
        const minutes = Math.floor(durationInSeconds / 60);
        const seconds = Math.floor(durationInSeconds % 60);
        
        return `${minutes}m ${seconds}s`;
    } catch (error) {
        console.error('Error calculating test duration:', error);
        return 'N/A';
    }
};

const getSystemInfo = () => {
    let cpuInfo = os.cpus()[0].model;
    return {
        CPU: cpuInfo
    };
};

// Log extracted information for debugging
console.log('Extracted script information:');
console.log('Headless:', headlessMode);
console.log('Environment:', environment);
console.log('Infrastructure:', infrastructure);
console.log('Browser:', browser);

report.generate({
    jsonDir: 'Reports/',  // Directory containing Cucumber JSON reports
    reportPath: reportDir, // Output directory for the HTML report
    metadata: {
        browser: {
            name: browser,
            version: 'Latest'
        },
        device: deviceName, 
        platform: {
            name: 'macOS'  // Hardcoded to macOS as requested
        }
    },
    displayDuration: true,
    pageTitle: "KonfigAI Automation Report",
    reportName: "Playwright Test Execution Report",
    customData: {
        title: "Test Run Info",
        data: [
            { label: "Project", value: "KonfigAI" },
            { label: "Test Environment", value: environment.charAt(0).toUpperCase() + environment.slice(1) },
            { label: "Infrastructure", value: infrastructure },
            { label: "Execution Start Time", value: executionStartTime },
            { label: "Total Duration", value: getTestDuration() },
            { label: "Headless Mode", value: headlessMode },
            { label: "CPU", value: getSystemInfo().CPU }
        ]
    }
});

console.log(`Test report generated at: ${reportDir}`);
