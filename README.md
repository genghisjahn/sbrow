# sbrow

A tiny macOS CLI to switch your default browser between Chrome and Safari.

## Usage

```bash
sbrow              # show current default browser
sbrow chrome       # set default to Chrome
sbrow safari       # set default to Safari
sbrow help         # show usage
```

macOS will show a confirmation dialog when switching — this is an OS-level restriction that can't be bypassed without granting Accessibility permissions.

## Install

Requires Xcode command line tools (`xcode-select --install`).

```bash
# compile
swiftc sbrow.swift -o /opt/homebrew/bin/sbrow -framework CoreServices

# or put it wherever you like
swiftc sbrow.swift -o /usr/local/bin/sbrow -framework CoreServices
```

## How it works

Uses the macOS CoreServices API (`LSSetDefaultHandlerForURLScheme`) to set the default handler for `http`, `https`, `public.html`, and `public.xhtml`.
