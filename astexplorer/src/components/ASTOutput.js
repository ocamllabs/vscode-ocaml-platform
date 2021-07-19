import PropTypes from 'prop-types';
import React from 'react';
import cx from '../utils/classnames.js';
import visualizations from './visualization';
import { vscode } from '../vscode'

const { useState } = React;

function formatTime(time) {
  if (!time) {
    return null;
  }
  if (time < 1000) {
    return `${time}ms`;
  }
  return `${(time / 1000).toFixed(2)}s`;
}

export default function ASTOutput({ parseResult = {}, ppParseResult = {}, position = null }) {
  const [selectedOutput, setSelectedOutput] = useState(0);
  const { ast = null } = parseResult;
  let output;

  output = (
    <ErrorBoundary>
      {
        React.createElement(
          visualizations[0],
          { parseResult: (selectedOutput == 0 ? parseResult : ppParseResult), position, selectedOutput },
        )
      }
    </ErrorBoundary>
  )

  let buttons = visualizations.map(
    (_, index) =>
      <button
        key={index}
        value={index}
        onClick={event => {
          setSelectedOutput(event.target.value);
          vscode.postMessage({
            selectedOutput: event.target.value.toString()
          });
        }}
        className={cx({
          active: selectedOutput == index,
        })}>
        {index === 0 ? "Original" : "Preprocessed"}
      </button>
  );

  return (
    <div className="output highlight">
      <div className="toolbar">
        {buttons}
        <span className="time">
          {formatTime(parseResult.time)}
        </span>
      </div>
      {output}
    </div>
  );
}

ASTOutput.propTypes = {
  parseResult: PropTypes.object,
  position: PropTypes.number,
};

class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError() {
    // Update state so the next render will show the fallback UI.
    return { hasError: true };
  }

  render() {
    /*if (this.state.hasError) {
      // You can render any custom fallback UI
      return (
        <div style={{ padding: 20 }}>
          An error was caught while rendering the AST. This usually is an issue with
          astexplorer itself. Have a look at the console for more information.
          Consider <a href="https://github.com/fkling/astexplorer/issues/new?template=bug_report.md">filing a bug report</a>, but <a href="https://github.com/fkling/astexplorer/issues/">check first</a> if one doesn&quot;t already exist. Thank you!
        </div>
      );
    }*/
    return this.props.children;
  }
}

ErrorBoundary.propTypes = {
  children: PropTypes.node,
};

