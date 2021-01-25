always_load("singularity")

local sif_hash = '2849cde11401063e830efad004cfdf1fed9a708fd3cdde1e41ab8100da2d60c7'
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
  local cmd        = 'singularity exec --writable-tmpfs -B /scratch,/work,/run/user ' .. sif_file .. use_xvfb() .. app
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

