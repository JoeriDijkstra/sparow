defmodule Sparow.IMAP.Analyzer do
  def has_flag?(resp, flag) do
    flags = resp
    |> String.split("FLAGS (")
    |> Enum.at(1)
    |> String.split(")")
    |> Enum.at(0)
    |> String.split(" ")

    Enum.member?(flags, flag)
  end

  def get_mail_uid(resp) do
    resp
    |> String.split(") UID ")
    |> Enum.at(1)
    |> String.split(")")
    |> Enum.at(0)
  end

  def get_mail_content(resp) do
    case String.contains?(resp, "<--[Start Message]-->\r\n") && String.contains?(resp, "\r\n<--[End Message]-->") do
      true -> {:ok, analyze_mail(resp)}
      false -> {:error, "Message not setup properly"}
    end
  end

  defp analyze_mail(resp) do
    resp
    |> String.split("<--[Start Message]-->\r\n")
    |> Enum.at(1)
    |> String.split("\r\n<--[End Message]-->")
    |> Enum.at(0)
  end
end
