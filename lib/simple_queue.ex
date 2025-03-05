defmodule SimpleQueue do
  use GenServer

  @doc """
  Запуск и линковка очереди.
  Это вспомогательынй метод
  """
  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  ### Клиентский API / Функции помошников
  def queue do
    GenServer.call(__MODULE__, :queue)
  end

  def dequeue do
    GenServer.call(__MODULE__, :dequeue)
  end

  ###GenServer API

  @doc """
  Функция обратного вызова для GenServer.init/1
  """
  def init(state) do
    {:ok, state}
  end

  @doc """
  Функция обратного синхронного вызова для GenServer.handle_call/3
  """
  def handle_call(:dequeue, _from, [value | state]) do
    {:reply, value, state}
  end

  def handle_call(:dequeue, _from, []) do
    {:reply, nil, []}
  end

  def handle_call(:queue, _from, state) do
    {:reply, state, state}
  end

  @doc """
  Функция обратного асинхронного вызова для GenServer.handle_cast/3
  """
  def handle_cast({:enqueue, value}, state) do
    {:noreply, state ++ [value]}
  end

  def enqueue(value) do
    GenServer.cast(__MODULE__, {:enqueue, value})
  end

end
