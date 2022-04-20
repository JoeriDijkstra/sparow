defmodule Sparow.CronServer.Worker do
  def start_pipeline do
    response = GenServer.call(:imap_server, :execute, 10000)

    case response do
      {:ok, mail_content} -> ok_mail_pipeline(mail_content)
      {:error, message} -> error_mail_pipeline(message)
    end
  end

  defp ok_mail_pipeline(mail_content) do
    IO.puts("\nStarting new mail pipeline...")
    mail_content
  end

  defp error_mail_pipeline(message) do
    IO.puts("\n=============================================")
    IO.puts("\nNo action needed => #{message}")
    IO.puts("\n=============================================\n")
  end
end
