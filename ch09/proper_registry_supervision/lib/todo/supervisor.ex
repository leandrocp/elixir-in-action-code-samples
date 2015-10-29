# Top-level supervisor

defmodule Todo.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, nil)
  end

  def init(_) do
    processes = [
      worker(Todo.ProcessRegistry, []),
      supervisor(Todo.SystemSupervisor, [])
    ]

    # We use a :rest_for_one strategy, thus ensuring that a crash of the
    # process registry takes down the entire system
    supervise(processes, strategy: :rest_for_one)
  end
end