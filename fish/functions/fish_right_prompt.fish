# ░█▀▄░█░░░█▀█░█▀▀░█░█░█▀▀
# ░█▀▄░█░░░█░█░█░░░█▀▄░▀▀█
# ░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀

# Time stamp block
function _block_time_stamp -d 'Returns time stamp block'
	set block (set_color brcyan -o) '|' (date +%H:%M:%S)
	echo $block
end

# Status block
function _block_status -d 'Returns status block'
	if not test $status -eq 0
		set block (set_color red)'[✘]'
	else
		set block (set_color green)'[✔]'
	end
	echo $block
end

# Git block
function _block_git -d 'Returns Git block'
	if [ (fish_git_prompt) ]
		set git_bg (_fishblocks_git_status)
		set block (fish_git_prompt)
	else
		set git_bg normal
		set block (fish_git_prompt)
	end
	echo (set_color $git_bg -o) $block
end

# Override fish_default_mode_prompt and use the theme's custom prompt
function fish_default_mode_prompt -d 'Display the default mode for the prompt'
end

function _block_default_mode -d 'Returns the default mode for the prompt'
	set block
	# Check if in vi mode
	if test "$fish_key_bindings" = 'fish_vi_key_bindings'
		or test "$fish_key_bindings" = 'fish_hybrid_key_bindings'
		switch $fish_bind_mode
			case default
				set block (set_color brred -o)'N '
			case insert
				set block (set_color brgreen -o)'I '
			case replace_one
				set block (set_color brgreen -o)'R '
			case replace
				set block (set_color brcyan -o)'R '
			case visual
				set block (set_color brmagenta -o)'V '
		end
	end
	echo $block
end


# Private mode block
function _block_private -d 'Returns private mode block'
	if  not test -z $fish_private_mode
		set block (set_color black)' 﫸'
	else
		set block
	end
	echo $block
end

# ░█▀▄░▀█▀░█▀▀░█░█░▀█▀░░░░░█░█░█▀█░█▀█░█▀▄░░░█▀█░█▀▄░█▀█░█▄█░█▀█░▀█▀
# ░█▀▄░░█░░█░█░█▀█░░█░░▄▄▄░█▀█░█▀█░█░█░█░█░░░█▀▀░█▀▄░█░█░█░█░█▀▀░░█░
# ░▀░▀░▀▀▀░▀▀▀░▀░▀░░▀░░░░░░▀░▀░▀░▀░▀░▀░▀▀░░░░▀░░░▀░▀░▀▀▀░▀░▀░▀░░░░▀░

# Right-hand prompt
function fish_right_prompt -d 'Right-hand prompt'
	echo -ne (_block_git)(_block_time_stamp)(_block_default_mode)(_block_private)(set_color normal)
end
