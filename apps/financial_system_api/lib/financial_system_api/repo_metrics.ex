defmodule FinancialSystemApi.Repo.Metrics do
  @moduledoc """
  Module responseble to send ecto metrics to StatsD Agent.
  """

  alias FinancialSystemApi.Statsd

  require Logger

  def log(log_entry) do
    {:ok, statsd} = Statsd.build_statsd_agent()

    Statsd.histogram(
      statsd,
      "financial_system_api.ecto.query_exec_time",
      (log_entry.query_time + (log_entry.queue_time || 0)) / 1_000
    )

    Statsd.histogram(
      statsd,
      "financial_system_api.ecto.query_queue_time",
      (log_entry.queue_time || 0) / 1_000
    )

    Statsd.increment(
      statsd,
      "financial_system_api.ecto.query_count"
    )
  rescue
    e ->
      Logger.error("#{inspect(e)}")
      e
  end
end
