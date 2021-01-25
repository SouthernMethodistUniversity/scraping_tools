always_load("singularity/3.5.3")

local sif_hash = '8a749c0d4806b81a2ea2b8959db1bcad958f66e2cfae5364912fa861e16ac233'
local sif_file = '/hpc/applications/singularity_containers/scraping_tools_sha256.' .. sif_hash .. '.sif'

function use_xvfb()
  local value=os.getenv("USE_XVFB")
  if (value == nil or value == '' or value == '1' or value:lower() == 'true') then
    return ' xvfb-run -a '
  else
    return ' '
  end
end

function build_command(app)
  local cmd        = 'singularity exec --writable-tmpfs -B /scratch,/work,/run/user ' .. sif_file .. ' ' .. app
  local sh_ending  = ' "$@"'
  local csh_ending = ' $*'
  local sh_cmd     = cmd .. sh_ending
  local csh_cmd    = cmd .. csh_ending
  set_shell_function(app , sh_cmd, csh_cmd)
end

setenv('TMPDIR', '/dev/shm')

build_command('python3')
build_command('ipython3')
build_command('jupyter')

