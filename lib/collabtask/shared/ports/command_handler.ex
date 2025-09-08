defmodule Collabtask.Shared.Ports.CommandHandler do
  @type command :: any()
  @type dependencies :: map()
  @type result :: any()

  @callback handle(command(), dependencies()) :: result()
end
