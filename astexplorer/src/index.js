import React from "react";
import ReactDOM from "react-dom";
import "../css/style.css";
import InteractorFactory from "./Interaction/InteractorFactory";
import "regenerator-runtime";
import ASTOutput from "./components/ASTOutput";
import getTreeAdapter from "./parserMiddleware";
import newParser from "./parsers/refmt-ml";
const Interactor = InteractorFactory.create();

class Index extends React.Component {
  constructor(props) {
    super(props);
    this.state = { treeAdapter: getTreeAdapter(newParser) };
    this.state = {
      astResult: {
        ast: null,
        error: null,
        time: 120,
        treeAdapter: this.state.treeAdapter,
      },
      position: -2,
      ppAstResult: {
        ast: null,
        error: null,
        time: 120,
        treeAdapter: this.state.treeAdapter,
      },
    };
    window.addEventListener("contextmenu", (event) => {
      event.preventDefault();
      const xPos = event.pageX + "px";
      const yPos = event.pageY + "px";
      console.log(xPos); /* TODO rightclick action */
      console.log(yPos);
    });
    window.addEventListener("message", (event) => {
      switch (event.data.type) {
        case "ast":
          this.setState({
            astResult: {
              ast: event.data.value,
              error: null,
              time: 0,
              treeAdapter: getTreeAdapter(newParser),
            },
          });
          this.setState({
            error: null,
          });
          break;
        case "pp_ast":
          this.setState({
            ppAstResult: {
              ast: event.data.value,
              error: null,
              time: 0,
              treeAdapter: getTreeAdapter(newParser),
            },
          });
          this.setState({
            error: null,
          });
          break;
        case "focus":
          this.setState({ position: event.data.value });
          break;
        case "error":
          this.setState({ error: event.data.value });
          break;
      }
    });
  }

  updateFilesToDisplay() {
    Interactor.getDirectoryInfo((directoryInfo) => {
      this.setState({ directoryInfo: directoryInfo });
    });
  }

  render() {
    return (
      <>
        <div className="container">
          <ASTOutput
            parseResult={this.state.astResult}
            ppParseResult={this.state.ppAstResult}
            position={this.state.position}
            error={this.state.error}
          />
          {this.message}
        </div>
      </>
    );
  }
}

ReactDOM.render(<Index />, document.getElementById("index"));
