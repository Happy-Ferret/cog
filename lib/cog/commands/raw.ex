defmodule Cog.Command.Raw do
  use Cog.Command.GenCommand.Base, bundle: Cog.embedded_bundle

  alias Cog.Command.Request


  @moduledoc """
  Show the raw output of a command, exclusive of any templating. Useful as a
  debugging tool for command authors.

  USAGE
    raw

  EXAMPLE
    echo foo | raw
    > {
        "body": [
          "foo"
        ]
      }

  """

  rule "when command is #{Cog.embedded_bundle}:raw allow"

  def handle_message(%Request{cog_env: nil}=req, state),
    do: {:reply, req.reply_to, "nil", state}
  def handle_message(req, state),
    do: {:reply, req.reply_to, "json", req.cog_env, state}

end
