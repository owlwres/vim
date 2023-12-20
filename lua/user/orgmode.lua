require'orgmode'.setup_ts_grammar()
require'orgmode'.setup({
    org_agenda_files = {'~/org/**'},
    org_default_notes_file = '~/org/refile.org',
    org_todo_keywords = {'TODO(t)', 'WAITING(w)', '|', 'DONE(d)'},
    notifications = {
        enabled = true,
        cron_enabled = false
    }
})
