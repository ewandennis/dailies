defmodule Giflator.SlideController do
  use Giflator.Web, :controller

  alias Giflator.Slide

  def index(conn, _params) do
    slides = Repo.all(Slide)
    render(conn, "index.json", slides: slides)
  end

  def create(conn, %{"slide" => slide_params}) do
    changeset = Slide.changeset(%Slide{}, slide_params)

    case Repo.insert(changeset) do
      {:ok, slide} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", slide_path(conn, :show, slide))
        |> render("show.json", slide: slide)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Giflator.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    slide = Repo.get!(Slide, id)
    render(conn, "show.json", slide: slide)
  end

  def update(conn, %{"id" => id, "slide" => slide_params}) do
    slide = Repo.get!(Slide, id)
    changeset = Slide.changeset(slide, slide_params)

    case Repo.update(changeset) do
      {:ok, slide} ->
        render(conn, "show.json", slide: slide)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Giflator.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    slide = Repo.get!(Slide, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(slide)

    send_resp(conn, :no_content, "")
  end
end
