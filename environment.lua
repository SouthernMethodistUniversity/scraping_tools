require("lfs")
always_load("singularity")

function use_xvfb()
  local value=os.getenv("USE_XVFB")
  if (value == nil or value == '' or value == '1' or value:lower() == 'true') then
    return ' xvfb-run -a '
  else
    return ' '
  end
end

function build_command(app)
  local container     = 'docker://smuresearch/scraping_tools:latest '
  local cmd_beginning = 'singularity exec --writable-tmpfs -B /scratch,/work,/run/user '
  local sh_cmd        = cmd_beginning .. container .. use_xvfb() .. app .. ' "$@"'
  local csh_cmd       = cmd_beginning .. container .. use_xvfb() .. app .. ' $*'
  set_shell_function(app , sh_cmd, csh_cmd)
end

setenv('TMPDIR', '/dev/shm')

build_command('python3')
build_command('ipython3')
build_command('jupyter')

