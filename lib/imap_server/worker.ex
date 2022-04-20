defmodule Sparow.IMAP.Worker do
  alias Sparow.IMAP.{Analyzer, CurlWrapper}

  def get_mail_uid(resp) do
    # Analyze and output value
    mail_uid = Analyzer.get_mail_uid(resp)
    IO.puts("\nAnalysis completed -> #{mail_uid}")

    # Return value
    mail_uid
  end

  def get_mail(state, args) do
    CurlWrapper.get_mail(state, args)
  end

  def get_mail_content(state) do
    state
    |> CurlWrapper.get_full_mail()
    |> Analyzer.get_mail_content()
  end

  def get_latest_mail(state) do
    CurlWrapper.get_latest_mail(state)
  end

  def set_flag(flag, state, method) do
    CurlWrapper.set_flag(flag, state, method)
  end

  def has_flag(state, flag) do
    CurlWrapper.get_mail(state, "FLAGS")
    |> Analyzer.has_flag?(flag)
  end

  def execute(state) do
    get_latest_mail(state)

    case has_flag(state, "\\Seen") do
      false -> has_flag_pipeline(state)
      true -> {:error, "Mail already read"}
    end
  end

  def has_flag_pipeline(state) do
    set_flag("\\Seen", state, :add)
    {status, response} = get_mail_content(state)

    GenServer.call(:logging_server, {:log, response})
    IO.puts("\nPipeline complete -> log created")

    {status, response}
  end
end
