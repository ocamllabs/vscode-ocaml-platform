import type { ButtonHTMLAttributes } from "react";

import { cn } from "../utils/cn";

export default function InlineButton({
  className,
  type,
  ...props
}: ButtonHTMLAttributes<HTMLButtonElement>) {
  return (
    <button
      type={type ?? "button"}
      className={cn(
        "font-inherit inline cursor-pointer border-0 bg-transparent p-0 hover:underline",
        className,
      )}
      {...props}
    />
  );
}
