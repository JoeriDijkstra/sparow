defmodule Sparow.Logging.Worker do
  def log_to_file(log) do
    # Write out log to file
    logname = "Log from " <> to_string(DateTime.utc_now())
    :ok = File.write("logs/" <> logname, log)

    # Return logname
    logname
  end
end
