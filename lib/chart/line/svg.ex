defmodule Chart.Line.Svg do
  @moduledoc false

  alias Chart.Line.Templates.{AxisSvg, GridSvg, LinesSvg, TitleSvg}
  alias Chart.Line.View

  use Phoenix.HTML

  def generate(line) do
    line_settings = line.settings
    {fig_width, fig_height} = line_settings.figure.viewbox

    {rect_bg_pos_x, rect_bg_pos_y, rect_bg_width, rect_bg_height} =
      View.plot_rect_bg(line_settings.plot)

    assigns =
      line_settings
      |> Map.put(:data, line.storage.data)
      |> Map.put(:fig_width, fig_width)
      |> Map.put(:fig_height, fig_height)
      |> Map.put(:rect_bg_pos_x, rect_bg_pos_x)
      |> Map.put(:rect_bg_pos_y, rect_bg_pos_y)
      |> Map.put(:rect_bg_width, rect_bg_width)
      |> Map.put(:rect_bg_height, rect_bg_height)
      |> Map.put(:axis, AxisSvg.render(line_settings))
      |> Map.put(:grid, GridSvg.render(line_settings))
      |> Map.put(:lines, LinesSvg.render(line_settings, line.storage.data))
      |> Map.put(:title, TitleSvg.render(line_settings))

    ~E"""
    <svg version="1.2" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
      viewbox="0 0 <%= @fig_width %> <%= @fig_height %>" >

      <rect id="figure_bg" width="100%" height="100%" />

      <%= @title %>

      <rect id="plot" x="<%= @rect_bg_pos_x %>" y="<%= @rect_bg_pos_y %>"
        width="<%= @rect_bg_width %>" height="<%= @rect_bg_height %>" />

      <%= @grid %>
      <%= @lines %>
      <%= @axis %>
    </svg>
    """
  end
end
