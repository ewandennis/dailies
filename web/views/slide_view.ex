defmodule Giflator.SlideView do
  use Giflator.Web, :view

  def render("index.json", %{slides: slides}) do
    %{data: render_many(slides, Giflator.SlideView, "slide.json")}
  end

  def render("show.json", %{slide: slide}) do
    %{data: render_one(slide, Giflator.SlideView, "slide.json")}
  end

  def render("slide.json", %{slide: slide}) do
    %{id: slide.id,
      url: slide.url}
  end
end
