export default function stringify(value: unknown): string {
  switch (typeof value) {
    case "object":
      return value === null ? "null" : JSON.stringify(value);
    case "undefined":
      return "undefined";
    case "number":
      return Number.isNaN(value) ? "NaN" : String(value);
    default:
      return JSON.stringify(value);
  }
}
