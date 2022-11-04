/**
 * @brief The main DPM simulator program
 */

#include "inc/psm.h"
#include "inc/dpm_policies.h"
#include "inc/utilities.h"

#define MAX_FILENAME 256

int main(int argc, char *argv[]) {

    char fwl[MAX_FILENAME];
    psm_t psm;
    dpm_timeout_params tparams;
    dpm_history_params hparams;
    dpm_policy_t sel_policy;

    tparams.timeout_sleep = 1000000;
    if(!parse_args(argc, argv, fwl, &psm, &sel_policy, &tparams, &hparams)) {
        printf("[error] reading command line arguments\n");
        return -1;
    }
    //printf("%f - %f\n", (float)tparams.timeout, (float)(tparams.timeout_sleep));
    psm_print(psm);
	dpm_simulate(psm, sel_policy, tparams, hparams, fwl);
}
