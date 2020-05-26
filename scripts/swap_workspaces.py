#!/usr/bin/python3

import i3

# retrieve only active outputs
outputs = list(filter(lambda output: output["active"], i3.get_outputs()))

current_ws = i3.filter(i3.get_workspaces(), focused=True)[0]["name"]

for output in outputs:
    # set current workspace to the one active on that output
    i3.workspace(output["current_workspace"])
    # ..and move it to the output to the right.
    # outputs wrap, so the right of the right is left ;)
    i3.command("move", "workspace to output right")

i3.workspace(current_ws)
