import { useState } from "react";
import type { MouseEventHandler, ReactElement, ReactNode } from "react";

import type { AstValue } from "../../../ast";
import type { TreeAdapter } from "../../../core/TreeAdapter";
import { OPEN_STATES } from "../../../hooks/useDisclosure";
import type { OpenState } from "../../../hooks/useDisclosure";
import { useNodeInteraction } from "../../../hooks/useNodeInteraction";
import stringify from "../../../utils/stringify";
import InlineButton from "../../InlineButton";
import { useTree } from "../TreeContext";
import CompactArrayView from "./CompactArrayView";
import CompactObjectView from "./CompactObjectView";

interface ContainerProps {
  name?: string;
  value: AstValue;
  open?: boolean;
  level: number;
}

interface VariantProps extends ContainerProps {
  isInRange: boolean;
  hasChildrenInRange: boolean;
  selected: boolean;
  onToggle: (state: OpenState) => void;
}

function renderChild(
  adapter: TreeAdapter,
  openState: OpenState,
  level: number,
  key: string,
  childValue: AstValue,
  childName: string,
): ReactElement {
  if (adapter.isArray(childValue) || adapter.isObject(childValue)) {
    return (
      <ElementContainer
        key={key}
        name={childName}
        open={openState === OPEN_STATES.DEEP_OPEN}
        value={childValue}
        level={level + 1}
      />
    );
  }
  return <PrimitiveElement key={key} name={childName} value={childValue} />;
}

interface ContainerRowProps {
  name: string;
  level: number;
  isInRange: boolean;
  hasChildrenInRange: boolean;
  isOpen: boolean;
  showToggler: boolean;
  valueOutput: ReactNode;
  prefix: string | null;
  suffix: string | null;
  content: ReactNode;
  onToggleClick: MouseEventHandler;
  onMouseOver: MouseEventHandler<HTMLLIElement> | undefined;
  onFocus: (() => void) | undefined;
}

function ContainerRow({
  name,
  level,
  isInRange,
  hasChildrenInRange,
  isOpen,
  showToggler,
  valueOutput,
  prefix,
  suffix,
  content,
  onToggleClick,
  onMouseOver,
  onFocus,
}: ContainerRowProps) {
  const highlighted =
    (isInRange && (!hasChildrenInRange || !isOpen)) ||
    (!isInRange && hasChildrenInRange && !isOpen);

  return (
    // oxlint-disable-next-line jsx-a11y/no-noninteractive-element-interactions
    <li
      data-focus-target={isInRange && !hasChildrenInRange ? "" : undefined}
      data-highlighted={highlighted ? "" : undefined}
      data-state={showToggler ? (isOpen ? "open" : "closed") : undefined}
      data-marker={!showToggler && level !== 0 ? "leaf" : undefined}
      className="before:text-muted data-highlighted:bg-selection relative list-none px-1 before:absolute before:left-[-10px] data-highlighted:rounded-xs data-[marker=leaf]:before:content-['•'] data-[state=closed]:before:content-['›'] data-[state=open]:before:content-['⌄']"
      onMouseOver={onMouseOver}
      onFocus={onFocus}
    >
      {name ? <PropertyName name={name} onClick={onToggleClick} /> : null}
      <span className="whitespace-pre-wrap">{valueOutput}</span>
      {prefix ? <span className="text-muted">{prefix}</span> : null}
      {content}
      {suffix ? <div className="text-muted">{suffix}</div> : null}
    </li>
  );
}

function ArrayElement({
  name,
  value,
  open,
  level,
  isInRange,
  hasChildrenInRange,
  onToggle,
}: VariantProps) {
  const { adapter } = useTree();
  const { openState, isOpen, onToggleClick, onMouseOver, onFocus } = useNodeInteraction(
    value,
    open,
    level,
    isInRange,
    hasChildrenInRange,
    onToggle,
  );

  const count = (value as { length: number }).length;
  const showToggler = count > 0;

  if (showToggler && isOpen) {
    const elements = Array.from(adapter.walkNode(value)).map(({ key, value: childValue }) =>
      renderChild(adapter, openState, level, key, childValue, Number.isInteger(+key) ? "" : key),
    );
    if (level === 0) {
      return <>{elements}</>;
    }
    const content = <ul className="w-fit min-w-75 overflow-auto pl-4">{elements}</ul>;
    return (
      <ContainerRow
        name={name ?? ""}
        level={level}
        isInRange={isInRange}
        hasChildrenInRange={hasChildrenInRange}
        isOpen={isOpen}
        showToggler={showToggler}
        valueOutput={null}
        prefix="["
        suffix="]"
        content={content}
        onToggleClick={onToggleClick}
        onMouseOver={onMouseOver}
        onFocus={onFocus}
      />
    );
  }

  return (
    <ContainerRow
      name={name ?? ""}
      level={level}
      isInRange={isInRange}
      hasChildrenInRange={hasChildrenInRange}
      isOpen={isOpen}
      showToggler={showToggler}
      valueOutput={<CompactArrayView array={value as { length: number }} onClick={onToggleClick} />}
      prefix={null}
      suffix={null}
      content={null}
      onToggleClick={onToggleClick}
      onMouseOver={onMouseOver}
      onFocus={onFocus}
    />
  );
}

function ObjectElement({
  name,
  value,
  open,
  level,
  isInRange,
  hasChildrenInRange,
  selected,
  onToggle,
}: VariantProps) {
  const { adapter } = useTree();
  const { openState, isOpen, onToggleClick, onMouseOver, onFocus } = useNodeInteraction(
    value,
    open,
    level,
    isInRange,
    hasChildrenInRange,
    onToggle,
  );

  const nodeName = adapter.getNodeName(value);
  let valueOutput: ReactNode = nodeName ? (
    <InlineButton className="text-type mr-1.5" onClick={onToggleClick}>
      {nodeName}
      {selected ? <span className="text-muted text-[0.8em] italic">{" = $node"}</span> : null}
    </InlineButton>
  ) : null;

  let prefix: string | null = null;
  let suffix: string | null = null;
  let content: ReactNode = null;
  let showToggler: boolean;

  if (isOpen) {
    prefix = "{";
    suffix = "}";
    const elements = Array.from(adapter.walkNode(value)).map(({ key, value: childValue }) =>
      renderChild(adapter, openState, level, key, childValue, key),
    );
    content = <ul className="w-fit min-w-75 overflow-auto pl-4">{elements}</ul>;
    showToggler = elements.length > 0;
  } else {
    const keys = Array.from(adapter.walkNode(value), ({ key }) => key);
    valueOutput = (
      <span>
        {valueOutput}
        <CompactObjectView onClick={onToggleClick} keys={keys} />
      </span>
    );
    showToggler = keys.length > 0;
  }

  return (
    <ContainerRow
      name={name ?? ""}
      level={level}
      isInRange={isInRange}
      hasChildrenInRange={hasChildrenInRange}
      isOpen={isOpen}
      showToggler={showToggler}
      valueOutput={valueOutput}
      prefix={prefix}
      suffix={suffix}
      content={content}
      onToggleClick={onToggleClick}
      onMouseOver={onMouseOver}
      onFocus={onFocus}
    />
  );
}

function PrimitiveElement({ name, value }: { name?: string; value: AstValue }) {
  return (
    <li className="before:text-muted relative list-none px-1 before:absolute before:left-[-10px] before:content-['•']">
      {name ? <PropertyName name={name} /> : null}
      <span className="whitespace-pre-wrap">
        <span className="text-string cursor-text select-text">
          {stringify(value).replaceAll("\\", "")}
        </span>
      </span>
    </li>
  );
}

function PropertyName({ name, onClick }: { name?: string; onClick?: MouseEventHandler }) {
  return (
    <span>
      {onClick ? (
        <InlineButton className="text-foreground" onClick={onClick}>
          {name}
        </InlineButton>
      ) : (
        <span className="font-inherit text-foreground">{name}</span>
      )}
      <span className="text-muted">:&nbsp;</span>
    </span>
  );
}

export default function ElementContainer(props: ContainerProps) {
  const { adapter, position, focusPath, selectNode } = useTree();
  const [selected, setSelected] = useState(false);
  const key = props.name ?? "";

  const onToggle = (state: OpenState) => {
    if (state === OPEN_STATES.CLOSED) {
      selectNode(null);
      setSelected(false);
    } else {
      selectNode(props.value, () => setSelected(false));
      setSelected(true);
    }
  };

  const isArray = adapter.isArray(props.value);
  if (!isArray && !adapter.isObject(props.value)) {
    return null;
  }

  const variantProps: VariantProps = {
    ...props,
    selected,
    isInRange: adapter.isInRange(props.value, key, position),
    hasChildrenInRange: focusPath.has(props.value),
    onToggle,
  };

  return isArray ? <ArrayElement {...variantProps} /> : <ObjectElement {...variantProps} />;
}
