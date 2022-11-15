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

    //tparams.timeout_sleep = 1000000;
    if(!parse_args(argc, argv, fwl, &psm, &sel_policy, &tparams, &hparams)) {
        printf("[error] reading command line arguments\n");
        return -1;
    }
    //printf("TH1: %d - TH2: %d\n", (int)hparams.threshold[0], (int)hparams.threshold[1]);
    //printf("alpha 1:%f - 5: %f\n", hparams.alpha[0], hparams.alpha[4]);
    //printf("%f - %f\n", (float)tparams.timeout, (float)(tparams.timeout_sleep));
    //printf("%d\n", (int)sel_policy);
    psm_print(psm);
	dpm_simulate(psm, sel_policy, tparams, hparams, fwl);
}
