#include <amxmodx>
#include <reapi>

#define PLUGIN "[CSDM] Auto Double Jump"
#define VERSION "1.0"
#define AUTHOR "DadoDz"

new g_iJumpCount[33];

public plugin_init()
{
    register_plugin(PLUGIN, VERSION, AUTHOR);

    RegisterHookChain(RG_CBasePlayer_PreThink, "PlayerPreThink", false);
}

public client_putinserver(id) g_iJumpCount[id] = 0;
public client_disconnected(id) g_iJumpCount[id] = 0;

public PlayerPreThink(id)
{
    if (!is_user_alive(id))
        return;

    if ((get_entvar(id, var_button) & IN_JUMP) && !(get_entvar(id, var_flags) & FL_ONGROUND) && !(get_entvar(id, var_oldbuttons) & IN_JUMP))
    {
        if (g_iJumpCount[id] < 1)
        {
            static Float:velocity[3];
            get_entvar(id, var_velocity, velocity);
            velocity[2] = 285.0;
            set_entvar(id, var_velocity, velocity);
            g_iJumpCount[id]++;
        }
    }

    if ((get_entvar(id, var_button) & IN_JUMP) && (get_entvar(id, var_flags) & FL_ONGROUND))
        g_iJumpCount[id] = 0;
}