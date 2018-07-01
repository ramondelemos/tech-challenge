defmodule FinancialSystemApi.Repo.Metrics do
  @moduledoc """
  Module responseble to send ecto metrics to DataDog Agent.
  """

  require Logger

  alias FinancialSystemApi.StatsdWrapper

  def log(log_entry) do
    {:ok, statsd} = StatsdWrapper.build_statsd_agent()

    if statsd do
      StatsdWrapper.histogram(
        statsd,
        "financial_system_api.ecto.query_exec_time",
        (log_entry.query_time + (log_entry.queue_time || 0)) / 1_000
      )

      StatsdWrapper.histogram(
        statsd,
        "financial_system_api.ecto.query_queue_time",
        (log_entry.queue_time || 0) / 1_000
      )

      StatsdWrapper.increment(
        statsd,
        "financial_system_api.ecto.query_count"
      )
    end
  rescue
    e ->
      Logger.error("#{inspect(e)}")
      e
  end
end
