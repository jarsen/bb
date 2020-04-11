defmodule BBWeb.IntegrationCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use BBWeb.ConnCase
      use PhoenixIntegration
    end
  end
end
