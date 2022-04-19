--THe Console executes commands. in the init there is a table of commands passed in.

Console = Class{}

function Console:init(def)
  self.commands = def
end

--ExecuteString compares if the given string contains a command an seperates them from the arguments
--which the specific command in the cataloque can use for further description
--afterwards the command will be executed and reutrn wheter the command is finished or not.
function Console:ExecuteString(string, state)
  for k, command in pairs(self.commands) do
    if string.find(string, k) then
      x, y = string.find(string, k)
      local arg = string.sub(string, y + 1, #string)
      print(x, y, string, arg)

      return command(arg, state)
    end
  end
end
