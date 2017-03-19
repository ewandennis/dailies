defmodule Dailies.SlideView do
  use Dailies.Web, :view

  def render("index.json", %{slides: slides}) do
    %{data: render_many(slides, Dailies.SlideView, "slide.json")}
  end

  def render("show.json", %{slide: slide}) do
    %{data: render_one(slide, Dailies.SlideView, "slide.json")}
  end

  def render("slide.json", %{slide: slide}) do
    %{id: slide.id,
      url: slide.url}
  end
end
