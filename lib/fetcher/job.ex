defmodule An.FetcherJob do
  use GenServer
  use Timex

  require Logger

  alias An.Fetcher

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work() # Schedule work to be performed at some point
    {:ok, state}
  end

  def handle_info(:work, state) do
    Logger.info("[Fetcher Job] start")
    Fetcher.fetch_all
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    duration = 24 * 60 * 60 * 1000  # In 2 hours
    Process.send_after(self(), :work, duration)
  end
end
