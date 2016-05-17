defmodule Cog.Repo.Migrations.InsertErrorTemplates do
  use Ecto.Migration
  alias Cog.Models.Template
  alias Cog.Repo

  def change do

    execute """
    INSERT INTO templates(id, name, adapter, source, inserted_at, updated_at)
    VALUES
    ('#{new_uuid}', 'unregistered_user', 'any', '#{unregistered_source}', now(), now()),
    ('#{new_uuid}', 'error', 'any', '#{error_source}', now(), now())
    """
  end

  defp unregistered_source do
  """
  {{mention_name}}: I'm terribly sorry, but either I don't have a Cog account for you, or your {{display_name}} chat handle has not been registered. Currently, only registered users can interact with me.

  You'll need to ask a Cog administrator to fix this situation and to register your {{display_name}} handle. {{#user_creators?}}The following users can help you right here in chat:{{#user_creators}} {{.}}{{/user_creators}}{{/user_creators?}}
   """ |> String.replace("'", "''") # postgres escaping
  end

  defp error_source do
  """
    An error has occurred.

    At `{{started}}`, {{initiator}} initiated the following pipeline, assigned the unique ID `{{id}}`:

        `{{{pipeline_text}}}`

    {{#planning_failure}}
    The pipeline failed planning the invocation:

       `{{{planning_failure}}}`

    {{/planning_failure}}
    {{#execution_failure}}
    The pipeline failed executing the command:

        `{{{execution_failure}}}`
    {{/execution_failure}}
    The specific error was:

        {{{error_message}}}

    """
    end

      defp new_uuid,
    do: UUID.uuid4(:hex)

end
