
# KonfigAI Automation Framework

<p align="center">
  <img src="https://playwright.dev/img/playwright-logo.svg" alt="Playwright Logo" width="200"/>
</p>

<p align="center">
  A robust automation framework built to test the Konfig application using Playwright and Cucumber.
</p>

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Running Tests](#running-tests)
- [Test Reports](#test-reports)
- [Project Structure](#project-structure)
- [Troubleshooting](#troubleshooting)

## 🔧 Prerequisites

- Node.js (v14 or higher)
- npm (v6 or higher)
- Git

## 🚀 Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd /Users/saimanikantaakula/Documents/Konfig/playwright
```

2. Install dependencies:
```bash
npm install
npx playwright install
```

## ⚙️ Configuration

Before running tests, you need to update the test data:

1. Edit the resources/testdata.json file to update the test data:
```bash
nano resources/testdata.json
```

2. Update the group name in line 18 of the testdata.json file:
```json
{
  "GroupName": "YourGroupNameHere"
}
```

## 🏃‍♂️ Running Tests

### Available Scripts

Open `package.json` to see all available test scripts. Here's an example of running a basic regression test in the onPrem Dev environment:

```bash
npm run test-onPrem-dev
```

### What Happens When You Run This Command:

1. **Pre-test Setup**: 
   ```bash
   cross-env HEADLESS=true Env=Dev Infra=onPrem Browser=chromium npx cucumber-js -p test_runner --tags "@CreateGroupAndAPI"
   ```
   This creates necessary groups and API configurations (if they don't already exist).

2. **Main Test Execution**:
   ```bash
   cross-env HEADLESS=false Env=Dev Infra=onPrem Browser=chromium npx cucumber-js -p test_runner --parallel 1 --tags "@RS1"
   ```

   Where:
   - `HEADLESS=false`: Browser will be visible during test execution
   - `Env=Dev`: Testing in Development environment
   - `Infra=onPrem`: Using on-premises infrastructure
   - `Browser=chromium`: Tests will run in Chromium browser
   - `--tags "@RS1"`: Running tests tagged with RS1 (Regression Suite 1)
   - `--parallel 1`: Running tests in parallel
   
3. **Report Generation**:
   The HTML report is automatically generated after test completion.

### Other Environment Options

```bash
# Development Environment (Cloud)
npm run test-cloud-dev

# SIT Environment (On-Premises)
npm run test-onPrem-sit

# QA Environment (On-Premises)
npm run test-onPrem-qa

# Staging Environment (On-Premises)
npm run test-onPrem-stg
```

## 📊 Test Reports

After test execution, HTML reports are automatically generated in the Reports/TestReports directory:

```bash
open /Users/saimanikantaakula/Documents/Konfig/playwright/Reports/TestReports/
```

The report includes:
- Feature and scenario status
- Test environment details
- Execution time and duration
- Browser and platform information

## 📁 Project Structure

```
playwright/
├── features/            # Cucumber feature files
├── steps/               # Step definitions
├── Main/                # Core functionality classes
├── Utility/             # Helper functions
├── Resources/           # Test data files
├── Reports/             # Generated test reports
├── package.json         # Project dependencies and scripts
└── README.md            # Project documentation
```

## ❓ Troubleshooting

If you encounter issues:

1. Ensure all dependencies are correctly installed
2. Verify that the test data in testdata.json is valid
3. Check that the target environment is accessible
4. Review the test reports for detailed error information

---

<p align="center">
  For additional help, please contact the KonfigAI automation team.
</p>
```

This beautified README includes:
- Improved visual layout with emojis and centered text
- Better organization with a table of contents
- More detailed explanations of the test execution process
- Visual representation of the project structure
- Enhanced formatting for code blocks and commands
- Clearer troubleshooting section