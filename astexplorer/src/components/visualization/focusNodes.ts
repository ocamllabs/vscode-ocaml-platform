export function scrollClosestToCenter(root: HTMLElement, targets: ArrayLike<HTMLElement>): void {
  try {
    if (targets.length === 0) {
      return;
    }
    if (targets.length === 1) {
      targets[0]?.scrollIntoView();
      return;
    }
    const rootRect = root.getBoundingClientRect();
    const center = rootRect.y + rootRect.height / 2;
    let closest: HTMLElement | null = null;
    let closestDistance = Number.POSITIVE_INFINITY;
    for (let i = 0; i < targets.length; i++) {
      const element = targets[i];
      if (!element) {
        continue;
      }
      const elementRect = element.getBoundingClientRect();
      const distance = elementRect.y - center;
      const minDistance = Math.min(Math.abs(distance), Math.abs(distance + elementRect.height));
      if (minDistance < closestDistance) {
        closest = element;
        closestDistance = minDistance;
      }
    }
    closest?.scrollIntoView();
  } catch (e) {
    console.error("Unable to scroll node into view:", (e as Error).message);
  }
}
