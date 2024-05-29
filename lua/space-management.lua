-- plenary async
--

local command_all_neovim_spaces = '~/yabai/neovim-spaces.sh'
local command_get_label_current_space = '~/yabai/get-label-current-space.sh'
local command_set_label_current_space = "~/yabai/label-current-space-as-neovim-space.sh"

function index_from_label(label)
  local match = string.match(label, "neovim[-](%d+)")
  if match ~= nil then
    local space_index = match
    return tonumber(space_index)
  else
    return nil
  end
end

function asdf()
end

function label_current_space_as_neovim_space(index)
  os.execute(command_set_label_current_space .. " " .. index)
end

function current_space_is_labeled()
  local popen_result_file, errmsg = io.popen(command_get_label_current_space)
  if popen_result_file and not errmsg then
    for line in popen_result_file:lines() do
      local index = index_from_label(line)
      if index ~= nil then
        return true, true
      else
        return true, false
      end
    end
  end
  return false, nil
end

function handle_labelings()
  local status, result = current_space_is_labeled()
  if not status then
    return
  end
  if result then
    return
  end
  local popen_result_file, errmsg = io.popen(command_all_neovim_spaces)
  if popen_result_file and not errmsg then
    local space_index = 1
    for line in popen_result_file:lines() do
      local index = index_from_label(line)
      if index ~= nil and index == space_index then
        space_index = space_index + 1
      else
        break
      end
    end
    label_current_space_as_neovim_space(space_index)
  end
end

handle_labelings()
