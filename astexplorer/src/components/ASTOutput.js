import PropTypes from "prop-types";
import React from "react";
import cx from "../utils/classnames.js";
import visualizations from "./visualization";
import { vscode } from "../vscode";

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

export default function ASTOutput({
  parseResult = {},
  ppParseResult = {},
  position = null,
  error = null,
}) {
  const [selectedOutput, setSelectedOutput] = useState(0);
  const { ast = null } = parseResult;
  let output;
  output = (
    <ErrorBoundary>
      {React.createElement(visualizations[0], {
        parseResult: selectedOutput == 0 ? parseResult : ppParseResult,
        position,
        selectedOutput,
        error,
      })}
    </ErrorBoundary>
  );

  let buttons = visualizations.map((_, index) => (
    <button
      key={index}
      value={index}
      onClick={(event) => {
        setSelectedOutput(event.target.value);
        vscode.postMessage({
          selectedOutput: event.target.value.toString(),
        });
      }}
      className={cx({
        active: selectedOutput == index,
      })}
    >
      {index === 0 ? "Original" : "Preprocessed"}
    </button>
  ));

  return (
    <div className="output highlight">
      <div className="toolbar">
        {buttons}
        {/*         <span className="time">{formatTime(parseResult.time)}</span>
         */}{" "}
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
    this.state = { error: null, errorInfo: null };
  }

  componentDidCatch(error, errorInfo) {
    this.setState({
      error: error,
      errorInfo: errorInfo,
    });
  }

  render() {
    if (this.state.errorInfo) {
      return <h4 style={{ color: "red" }}>{this.state.error.toString()}</h4>;
    }
    return this.props.children;
  }
}

ErrorBoundary.propTypes = {
  children: PropTypes.node,
};
