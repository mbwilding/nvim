return {
    "uhs-robert/sshfs.nvim",
    opts = {
        connections = {
            ssh_configs = {
                "~/.ssh/config",
            },
        },
        mounts = {
            base_dir = vim.fn.expand("$HOME") .. "/mnt/nvim",
        },
        ui = {
            local_picker = {
                preferred_picker = "oil", -- snacks
            },
            remote_picker = {
                preferred_picker = "oil", -- snacks
            },
        },
        lead_prefix = "<leader>m", -- change keymap prefix (default: <leader>m)
        keymaps = {
            mount = "<leader>mm", -- creates an ssh connection and mounts via sshfs
            unmount = "<leader>mu", -- disconnects an ssh connection and unmounts via sshfs
            unmount_all = "<leader>mU", -- disconnects all ssh connections and unmounts via sshfs
            explore = "<leader>me", -- explore an sshfs mount using your native editor
            change_dir = "<leader>md", -- change dir to mount
            command = "<leader>mo", -- run command on mount
            config = "<leader>mc", -- edit ssh config
            reload = "<leader>mr", -- manually reload ssh config
            files = "<leader>mf", -- browse files using chosen picker
            grep = "<leader>mg", -- grep files using chosen picker
            terminal = "<leader>mt", -- open ssh terminal session
        },
    },
}
