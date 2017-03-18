defmodule Giflator.EditorController do
  use Giflator.Web, :controller

  alias Giflator.Slide

  def index(conn, _params) do
    editor = Repo.all(Slide)
    render(conn, "index.html", editor: editor)
  end

  def new(conn, _params) do
    changeset = Slide.changeset(%Slide{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"editor" => editor_params}) do
    changeset = Slide.changeset(%Slide{}, editor_params)

    case Repo.insert(changeset) do
      {:ok, _editor} ->
        conn
        |> put_flash(:info, "Slide created successfully.")
        |> redirect(to: editor_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    editor = Repo.get!(Slide, id)
    render(conn, "show.html", editor: editor)
  end

  def edit(conn, %{"id" => id}) do
    editor = Repo.get!(Slide, id)
    changeset = Slide.changeset(editor)
    render(conn, "edit.html", editor: editor, changeset: changeset)
  end

  def update(conn, %{"id" => id, "editor" => editor_params}) do
    editor = Repo.get!(Slide, id)
    changeset = Slide.changeset(editor, editor_params)

    case Repo.update(changeset) do
      {:ok, editor} ->
        conn
        |> put_flash(:info, "Slide updated successfully.")
        |> redirect(to: editor_path(conn, :show, editor))
      {:error, changeset} ->
        render(conn, "edit.html", editor: editor, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    editor = Repo.get!(Slide, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(editor)

    conn
    |> put_flash(:info, "Slide deleted successfully.")
    |> redirect(to: editor_path(conn, :index))
  end
end
