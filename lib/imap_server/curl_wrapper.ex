defmodule Sparow.IMAP.CurlWrapper do
  def get_mail(state, args) do
    %{email: email, inbox: inbox, password: password, mail_uid: mail_uid} = state

    # Send CURL
    args = [
     "imaps://outlook.office365.com:993/#{inbox}",
     "-X",
     "UID FETCH #{mail_uid} (#{args})",
     "-u",
     "#{email}:#{password}"
   ]

   # Execute and return
   {resp, 0} = System.cmd("curl", args, [])

   IO.puts("\nCurl complete -> #{mail_uid}")

   resp
  end

  def get_full_mail(state) do
    %{email: email, inbox: inbox, password: password, mail_uid: mail_uid} = state

    # Send CURL
    args = [
     "imaps://outlook.office365.com:993/#{inbox}/;UID=#{mail_uid}",
     "-u",
     "#{email}:#{password}"
   ]

   # Execute and return
   {resp, 0} = System.cmd("curl", args, [])

   IO.puts("\nCurl complete -> #{mail_uid}")

   resp
  end

  def get_latest_mail(state) do
    %{email: email, inbox: inbox, password: password} = state

     # Send CURL
     args = [
      "imaps://outlook.office365.com:993/#{inbox}",
      "-X",
      "UID FETCH *:* (ENVELOPE FLAGS UID)",
      "-u",
      "#{email}:#{password}"
    ]

    # Execute and return
    {resp, 0} = System.cmd("curl", args, [])

    IO.puts("\nCurl complete -> Data fetched")

    resp
  end

  def set_flag(flag, state, method) do
    if Map.has_key?(state, :mail_uid) do
      %{mail_uid: mail_uid, email: email, inbox: inbox, password: password} = state

      # Ensure the right method is used
      str_method =
        case method do
          :add -> "+"
          :remove -> "-"
        end

      # Send CURL
      args = [
        "imaps://outlook.office365.com:993/#{inbox}",
        "-X",
        "UID STORE #{mail_uid} #{str_method}Flags #{flag}",
        "-u",
        "#{email}:#{password}"
      ]

      System.cmd("curl", args, [])

      # Output value
      IO.puts("\nSet flag (#{str_method}) at " <> to_string(NaiveDateTime.utc_now()))
    end
  end
end
