defmodule Sparow.IMAP.Server do
  use GenServer
  alias Sparow.IMAP.Worker

  def init(state) do
    IO.puts("IMAP server initialized")
    {:ok, state}
  end

  def handle_call(:view, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:get_mail, _form, state) do
    resp = Worker.get_mail_content(state)
    {:reply, resp, state}
  end

  def handle_cast({:add_flag, flag}, state) do
    Worker.set_flag(flag, state, :add)
    {:noreply, state}
  end

  def handle_cast({:remove_flag, flag}, state) do
    Worker.set_flag(flag, state, :remove)
    {:noreply, state}
  end

  def handle_cast(:get_latest_mail, state) do
    response = Worker.get_latest_mail(state) |> Worker.get_mail_uid()
    new_state = Map.put(state, :mail_uid, response)
    {:noreply, new_state}
  end

  def handle_call(:execute, _form, state) do
    latest_mail = Worker.get_latest_mail(state) |> Worker.get_mail_uid()
    new_state = Map.put(state, :mail_uid, latest_mail)
    response = Worker.execute(new_state)
    {:reply, response, state}
  end
end
