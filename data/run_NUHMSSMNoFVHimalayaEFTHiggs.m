Get["models/NUHMSSMNoFVHimalayaEFTHiggs/NUHMSSMNoFVHimalayaEFTHiggs_librarylink.m"];
Get["model_files/NUHMSSMNoFVHimalayaEFTHiggs/NUHMSSMNoFVHimalayaEFTHiggs_uncertainty_estimate.m"];

Mtpole = 173.34;

settings = {
    precisionGoal -> 1.*^-5,
    maxIterations -> 1000,
    betaFunctionLoopOrder -> 4,
    poleMassLoopOrder -> 3,
    ewsbLoopOrder -> 3,
    (* forceOutput -> 1, (\* ignore mA tachyons *\) *)
    thresholdCorrectionsLoopOrder -> 3,
    thresholdCorrections -> 123111321
};

smpars = {
    alphaEmMZ -> 1/127.916, (* SMINPUTS[1] *)
    GF -> 1.166378700*^-5,  (* SMINPUTS[2] *)
    alphaSMZ -> 0.1184,     (* SMINPUTS[3] *)
    MZ -> 91.1876,          (* SMINPUTS[4] *)
    mbmb -> 4.18,           (* SMINPUTS[5] *)
    Mt -> Mtpole,           (* SMINPUTS[6] *)
    Mtau -> 1.777,          (* SMINPUTS[7] *)
    Mv3 -> 0,               (* SMINPUTS[8] *)
    MW -> 80.385,           (* SMINPUTS[9] *)
    Me -> 0.000510998902,   (* SMINPUTS[11] *)
    Mv1 -> 0,               (* SMINPUTS[12] *)
    Mm -> 0.1056583715,     (* SMINPUTS[13] *)
    Mv2 -> 0,               (* SMINPUTS[14] *)
    md2GeV -> 0.00475,      (* SMINPUTS[21] *)
    mu2GeV -> 0.0024,       (* SMINPUTS[22] *)
    ms2GeV -> 0.104,        (* SMINPUTS[23] *)
    mcmc -> 1.27,           (* SMINPUTS[24] *)
    CKMTheta12 -> 0,
    CKMTheta13 -> 0,
    CKMTheta23 -> 0,
    CKMDelta -> 0,
    PMNSTheta12 -> 0,
    PMNSTheta13 -> 0,
    PMNSTheta23 -> 0,
    PMNSDelta -> 0,
    PMNSAlpha1 -> 0,
    PMNSAlpha2 -> 0,
    alphaEm0 -> 1/137.035999074,
    Mh -> 125.09
};

NUHMSSMNoFVHimalayaEFTHiggsCalcMhDMh[MS_, TB_, Xtt_] :=
    CalcNUHMSSMNoFVHimalayaEFTHiggsDMh[
        fsSettings -> settings,
        fsSMParameters -> smpars,
        fsModelParameters -> {
            MSUSY   -> MS,
            M1Input -> MS,
            M2Input -> MS,
            M3Input -> MS,
            MuInput -> MS,
            mAInput -> MS,
            TanBeta -> TB,
            mq2Input -> MS^2 IdentityMatrix[3],
            mu2Input -> MS^2 IdentityMatrix[3],
            md2Input -> MS^2 IdentityMatrix[3],
            ml2Input -> MS^2 IdentityMatrix[3],
            me2Input -> MS^2 IdentityMatrix[3],
            AuInput -> {{0    , 0    , 0},
                        {0    , 0    , 0},
                        {0    , 0    , MS/TB + Xtt MS}},
            AdInput -> 0 IdentityMatrix[3],
            AeInput -> 0 IdentityMatrix[3]
        }
   ] /. $Failed -> nan;

Xtt = -Sqrt[6];
TBX = 20;
MSX = 3000;

(* scan over MS *)

msValues = 10^Subdivide[Log[10,10^2], Log[10,10^4], 50];

(* msValues = {2000}; *)

scanMS = ParallelMap[{N[#], Sequence @@ NUHMSSMNoFVHimalayaEFTHiggsCalcMhDMh[#, TBX, Xtt]}&, msValues];

Export["NUHMSSMNoFVHimalayaEFTHiggs_MS-Mh-DMh_TB-" <> ToString[TBX] <> "_xt-" <> ToString[N[Xtt]] <> ".dat", scanMS];

(* scan over xt *)

xtValues = Subdivide[-3.5, 3.5, 60];

scanXt = ParallelMap[{N[#], Sequence @@ NUHMSSMNoFVHimalayaEFTHiggsCalcMhDMh[MSX, TBX, #]}&, xtValues];

Export["NUHMSSMNoFVHimalayaEFTHiggs_Xt-Mh-DMh_MS-" <> ToString[MSX] <> "_TB-" <> ToString[TBX] <> ".dat", scanXt];
