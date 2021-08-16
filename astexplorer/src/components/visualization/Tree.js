import Element from "./tree/Element";
import PropTypes from "prop-types";
import React from "react";
import { publish } from "../../utils/pubsub.js";
import { logEvent } from "../../utils/logger";
import { treeAdapterFromParseResult } from "../../core/TreeAdapter.js";
import { SelectedNodeProvider } from "./SelectedNodeContext.js";
import focusNodes from "./focusNodes.js";

import "./css/tree.css";

const { useReducer, useMemo, useRef, useLayoutEffect } = React;

const STORAGE_KEY = "tree_settings";

function initSettings() {
  const storedSettings = global.localStorage.getItem(STORAGE_KEY);
  return storedSettings
    ? JSON.parse(storedSettings)
    : {
      autofocus: true,
      hideEmptyKeys: false,
      hideLocationData: false,
      hideTypeKeys: true,
    };
}

function reducer(state, element) {
  const newState = { ...state, [element.name]: element.checked };

  global.localStorage.setItem(STORAGE_KEY, JSON.stringify(newState));
  logEvent(
    "tree_view_settings",
    element.checked ? "enabled" : "disabled",
    element.name
  );

  return newState;
}

function makeCheckbox(name, settings, updateSettings) {
  return (
    <input
      type="checkbox"
      name={name}
      checked={settings[name]}
      onChange={(event) => updateSettings(event.target)}
    />
  );
}

export default function Tree({
  parseResult,
  position,
  error
}) {
  if (error) {
    return <h4 style={{ color: "red" }}>{error.toString()}</h4>;
  }
  const [settings, updateSettings] = useReducer(reducer, null, initSettings);
  const treeAdapter = useMemo(
    () => treeAdapterFromParseResult(parseResult, settings),
    [parseResult.treeAdapter, settings]
  );
  const rootElement = useRef();

  focusNodes("init");
  useLayoutEffect(() => {
    focusNodes("focus", rootElement);
  });

  return (
    <div className="tree-visualization container">
      <div className="toolbar">
        {treeAdapter.getConfigurableFilters().map((filter) =>
          filter.key != "hideTypeKeys" ? (
            <span key={filter.key}>
              <label>
                {makeCheckbox(filter.key, settings, updateSettings)}
                {filter.label}
              </label>
              &#8203;
            </span>
          ) : (
            ""
          )
        )}
      </div>
      <ul
        ref={rootElement}
        onMouseLeave={() => {
          /*publish('CLEAR_HIGHLIGHT');*/
        }}
      >
        <SelectedNodeProvider>
          <Element
            value={parseResult.ast}
            level={0}
            treeAdapter={treeAdapter}
            autofocus={settings.autofocus}
            position={position}
          />
        </SelectedNodeProvider>
      </ul>
    </div>
  );
}

Tree.propTypes = {
  parseResult: PropTypes.object,
  position: PropTypes.number,
};
