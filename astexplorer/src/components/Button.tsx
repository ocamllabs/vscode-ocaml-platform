import { cva, type VariantProps } from "class-variance-authority";
import type { ButtonHTMLAttributes } from "react";

import { cn } from "../utils/cn";

const button = cva(
  "inline-flex shrink-0 cursor-pointer items-center justify-center rounded-xs border border-button-border px-2.75 py-1 text-[13px] whitespace-nowrap outline-ring select-none focus-visible:outline-1 focus-visible:outline-offset-2",
  {
    variants: {
      variant: {
        primary: "bg-primary text-primary-foreground hover:bg-primary-hover",
        secondary: "bg-secondary text-secondary-foreground hover:bg-secondary-hover",
      },
    },
    defaultVariants: {
      variant: "secondary",
    },
  },
);

interface ButtonProps
  extends ButtonHTMLAttributes<HTMLButtonElement>, VariantProps<typeof button> {}

export default function Button({ variant, className, type, ...props }: ButtonProps) {
  return (
    <button type={type ?? "button"} className={cn(button({ variant }), className)} {...props} />
  );
}
