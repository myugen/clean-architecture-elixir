defmodule Collabtask.Shared.Types.Result do
  @type t(success, error) :: {:ok, success} | {:error, error}
  @type t(success) :: {:ok, success} | {:error, term()}
end
