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
        case "parse":
          var parseRes = event.data.value;
          this.setState({
            astResult: {
              ast: parseRes.ast,
              error: null,
              time: 120,
              treeAdapter: getTreeAdapter(newParser),
            },
          });
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
            position={this.state.position}
          />
          {this.message}
        </div>
      </>
    );
  }
}

ReactDOM.render(<Index />, document.getElementById("index"));
