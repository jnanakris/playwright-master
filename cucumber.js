let options = [
  '--require-module ts-node/register',
  '--require ./steps/*.steps.ts',
  '--require ./Utility/Util/Commonsteps/*.ts',
  '--format json:Reports/cucumber_report.json',
  '--publish-quiet'
].join(' ');

let run_features = [
  './features/', 
  options
].join(' ');

module.exports = {
  test_runner: run_features
};
