defmodule Chart.Internal.Figure do
  @moduledoc false

  import Chart.Internal.Guards, only: [is_positive_number: 1]

  def new() do
    %{
      viewbox: {800, 600},
      preserve_aspect_ratio: "xMidYMid meet"
    }
  end

  def add(settings) when is_map(settings) do
    Map.put(settings, :figure, new())
  end

  def set_viewbox(settings, {width, height} = viewbox)
      when is_positive_number(width) and is_positive_number(height) do
    put_in(settings, [:figure, :viewbox], viewbox)
  end

  def set_aspect_ratio(settings, par) when is_map(settings) and is_binary(par) do
    put_in(settings, [:figure, :preserve_aspect_ratio], par)
  end
end
