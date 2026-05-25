% ===== KOA Combined Output | contract_id: contrato_ocs_295_2024 =====

% ===== 1) UFO Ontology =====
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY EM PROLOG
% Inspirada em UFO-L + UFO-S + Service Contract Ontology (Griffo et al., 2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% META-ESTRUTURA (TBox: classes, especializações, relações entre classes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicados básicos de metamodelo
class(C).          % C é uma classe ontológica
subclass_of(C, P). % C é subclasse de P
disjoint(C1, C2).  % C1 e C2 são disjuntas conceitualmente

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Núcleo UFO-A / UFO-C simplificado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(agent).           % agente (pessoa, organização etc.)
class(relator).         % relator genérico
class(moment).          % propriedade/momento (trope no sentido do UFO)

class(social_relator).
class(legal_relator).

subclass_of(social_relator, relator).
subclass_of(legal_relator, social_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEGAL MOMENTS E LEGAL RELATORS (UFO-L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(legal_moment).
class(legal_entitlement).      % vantagens jurídicas
class(legal_burden_or_lack).  % ônus / falta de prerrogativa

subclass_of(legal_entitlement, legal_moment).
subclass_of(legal_burden_or_lack, legal_moment).

% Tipos de legal relators
class(simple_legal_relator).
class(complex_legal_relator).

subclass_of(simple_legal_relator, legal_relator).
subclass_of(complex_legal_relator, legal_relator).

% ---------------------------------------------------------------------------
% Right / Duty
% ---------------------------------------------------------------------------

class(right).
class(right_to_action).
class(right_to_omission).

class(duty).
class(duty_to_act).
class(duty_to_omit).

subclass_of(right, legal_entitlement).
subclass_of(right_to_action, right).
subclass_of(right_to_omission, right).

subclass_of(duty, legal_burden_or_lack).
subclass_of(duty_to_act, duty).
subclass_of(duty_to_omit, duty).

% ---------------------------------------------------------------------------
% NoRight / Permission
% ---------------------------------------------------------------------------

class(no_right).
class(no_right_to_action).
class(no_right_to_omission).

class(permission).
class(permission_to_act).
class(permission_to_omit).

subclass_of(no_right, legal_burden_or_lack).
subclass_of(no_right_to_action, no_right).
subclass_of(no_right_to_omission, no_right).

subclass_of(permission, legal_entitlement).
subclass_of(permission_to_act, permission).
subclass_of(permission_to_omit, permission).

% ---------------------------------------------------------------------------
% Power / Subjection (Liability)
% ---------------------------------------------------------------------------

class(power).
class(subjection).

subclass_of(power, legal_entitlement).
subclass_of(subjection, legal_burden_or_lack).

% ---------------------------------------------------------------------------
% Disability / Immunity
% ---------------------------------------------------------------------------

class(disability).
class(immunity).

subclass_of(disability, legal_burden_or_lack).
subclass_of(immunity, legal_entitlement).

% ---------------------------------------------------------------------------
% Liberty (liberdade desprotegida como complex legal relator)
% ---------------------------------------------------------------------------

class(liberty_relator).
subclass_of(liberty_relator, complex_legal_relator).

% ---------------------------------------------------------------------------
% Tipos de Simple Legal Relator (pares correlatos)
% ---------------------------------------------------------------------------

class(right_duty_relator).
class(noright_permission_relator).
class(power_subjection_relator).
class(disability_immunity_relator).

subclass_of(right_duty_relator, simple_legal_relator).
subclass_of(noright_permission_relator, simple_legal_relator).
subclass_of(power_subjection_relator, simple_legal_relator).
subclass_of(disability_immunity_relator, simple_legal_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CORRELAÇÃO ENTRE LEGAL MOMENTS (Hohfeld + Alexy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Correlatos em nível de classe
correlates(right_to_action,   duty_to_act).
correlates(duty_to_act,       right_to_action).

correlates(right_to_omission, duty_to_omit).
correlates(duty_to_omit,      right_to_omission).

correlates(permission_to_act,     no_right_to_action).
correlates(no_right_to_action,    permission_to_act).

correlates(permission_to_omit,    no_right_to_omission).
correlates(no_right_to_omission,  permission_to_omit).

correlates(power,      subjection).
correlates(subjection, power).

correlates(disability, immunity).
correlates(immunity,   disability).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE RELATIONS E SERVICE CONTRACTS (núcleo UFO-S simplificado)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(service_relation).
class(service_agreement).
class(legal_service_agreement).

subclass_of(service_agreement, service_relation).
subclass_of(legal_service_agreement, service_agreement).

% Papéis em relações de serviço
class(service_provider_role).
class(target_customer_role).
class(hired_service_provider_role).
class(service_customer_role).

subclass_of(hired_service_provider_role, service_provider_role).
subclass_of(service_customer_role,       target_customer_role).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY (Fig. 4 do artigo)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Em um Legal Service Agreement, cada parte tem Entitlements e Burdens/Lacks
class(hsp_entitlement).      % Hired Service Provider Entitlement
class(hsp_burden_or_lack).   % Hired Service Provider Burden/Lack
class(sc_entitlement).       % Service Customer Entitlement
class(sc_burden_or_lack).    % Service Customer Burden/Lack

subclass_of(hsp_entitlement, legal_entitlement).
subclass_of(sc_entitlement,  legal_entitlement).

subclass_of(hsp_burden_or_lack, legal_burden_or_lack).
subclass_of(sc_burden_or_lack,  legal_burden_or_lack).

% Composição: um Legal Service Agreement é composto de legal moments
% associados a cada papel (provider x customer).
relator_component(legal_service_agreement, hsp_entitlement).
relator_component(legal_service_agreement, hsp_burden_or_lack).
relator_component(legal_service_agreement, sc_entitlement).
relator_component(legal_service_agreement, sc_burden_or_lack).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESQUEMA PARA INSTÂNCIAS (ABox): AGENTES, ACORDOS, CLÁUSULAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% instance_of(Instancia, Classe).
% Você vai usar isso para criar indivíduos (contratos, cláusulas, agentes...).

:- dynamic instance_of/2.
:- dynamic plays_role/3.
:- dynamic legal_relation_instance/4.
:- dynamic clause_of/2.

% plays_role(Agente, Papel, Acordo).
% Ex.: plays_role(aws, hired_service_provider_role, aws_sns_agreement).
%      plays_role(cliente_x, service_customer_role, aws_sns_agreement).
plays_role(Agent, Role, Agreement).

% clause_of(ClauseId, Agreement).
% ClauseId é uma cláusula (ou grupo de cláusulas) de um acordo específico.
clause_of(ClauseId, Agreement).

% legal_relation_instance(ClauseId, LegalMoment, Bearer, Action).
%
% ClauseId   - identificador da cláusula
% LegalMoment- classe do momento jurídico (duty_to_omit, power, immunity...)
% Bearer     - quem tem esse momento (agente ou papel)
% Action     - ação/omissão ou descrição da conduta
%
% Exemplos (para você popular depois, inspirados no artigo):
% legal_relation_instance(clause_17_1, duty_to_omit, customer, share_service_with_third_parties).
% legal_relation_instance(clause_17_1, right_to_omission, provider, share_service_with_third_parties).

legal_relation_instance(ClauseId, LegalMomentClass, Bearer, Action) :-
    clause_of(ClauseId, _Agreement),
    class(LegalMomentClass),
    (   atom(Bearer)
    ;   plays_role(Bearer, _, _)
    ),
    atom(Action).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REGRAS AUXILIARES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fecho transitivo de subclass_of/2
subclass_of_trans(C, P) :-
    subclass_of(C, P).
subclass_of_trans(C, P) :-
    subclass_of(C, X),
    subclass_of_trans(X, P).

% is_a(Inst, Classe) — verifica se Inst é instância (direta ou indireta) de Classe
is_a(Inst, Classe) :-
    instance_of(Inst, C0),
    (   C0 = Classe
    ;   subclass_of_trans(C0, Classe)
    ).

% um legal_moment é um entitlement se a classe dele cai abaixo de legal_entitlement
is_entitlement(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_entitlement).

% um legal_moment é um burden/lack se cai abaixo de legal_burden_or_lack
is_burden_or_lack(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_burden_or_lack).

% Dado um LegalMomentClass, encontrar seu correlato (em termos de classe)
correlative_class(LMClass, CorrelateClass) :-
    correlates(LMClass, CorrelateClass).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIM DA ONTOLOGIA BASE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ===== 2) Generated UFO ABox =====
% UFO-only grounding generated from: KOA_Contrato_OCS_295_2024_-_Kryptus.pl
% contract_id: contrato_ocs_295_2024

instance_of(contrato_ocs_295_2024, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(kryptus_seguranca_da_informacao_s_a, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_295_2024).
plays_role(kryptus_seguranca_da_informacao_s_a, hired_service_provider_role, contrato_ocs_295_2024).

clause_of(clausula_primeira_objeto, contrato_ocs_295_2024).
clause_of(clausula_segunda_vigencia, contrato_ocs_295_2024).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_295_2024).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_295_2024).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_295_2024).
clause_of(clausula_sexta_preco, contrato_ocs_295_2024).
clause_of(clausula_setima_pagamento, contrato_ocs_295_2024).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_295_2024).
clause_of(clausula_oitava_paragrafo_primeiro, contrato_ocs_295_2024).
clause_of(clausula_oitava_paragrafo_segundo, contrato_ocs_295_2024).
clause_of(clausula_oitava_paragrafo_terceiro, contrato_ocs_295_2024).
clause_of(clausula_oitava_paragrafo_quarto, contrato_ocs_295_2024).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_295_2024).
clause_of(clausula_nona_paragrafo_primeiro, contrato_ocs_295_2024).
clause_of(clausula_nona_paragrafo_segundo, contrato_ocs_295_2024).
clause_of(clausula_decima_garantia_contratual, contrato_ocs_295_2024).
clause_of(clausula_decima_i_caucao_dinheiro, contrato_ocs_295_2024).
clause_of(clausula_decima_ii_seguro_garantia, contrato_ocs_295_2024).
clause_of(clausula_decima_ii_a_o_instrumento_de_apolice_de_seguro_deve_prever_expressamente, contrato_ocs_295_2024).
clause_of(clausula_decima_iii_fianca_bancaria, contrato_ocs_295_2024).
clause_of(clausula_decima_iii_a_o_instrumento_de_fianca_deve_prever_expressamente, contrato_ocs_295_2024).
clause_of(clausula_decima_paragrafo_primeiro, contrato_ocs_295_2024).
clause_of(clausula_decima_paragrafo_segundo, contrato_ocs_295_2024).
clause_of(clausula_decima_paragrafo_terceiro, contrato_ocs_295_2024).
clause_of(clausula_decima_paragrafo_quarto, contrato_ocs_295_2024).
clause_of(clausula_decima_paragrafo_quinto, contrato_ocs_295_2024).
clause_of(clausula_decima_paragrafo_sexto, contrato_ocs_295_2024).
clause_of(clausula_decima_paragrafo_setimo, contrato_ocs_295_2024).
clause_of(clausula_decima_primeira_obrigacoes_contratado, contrato_ocs_295_2024).
clause_of(clausula_decima_quinta_obrigacoes_bndes, contrato_ocs_295_2024).
clause_of(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, contrato_ocs_295_2024).
clause_of(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, contrato_ocs_295_2024).
clause_of(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_segundo, contrato_ocs_295_2024).
clause_of(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_terceiro, contrato_ocs_295_2024).
clause_of(clausula_decima_oitava_penalidades, contrato_ocs_295_2024).
clause_of(clausula_decima_oitava_penalidades_paragrafo_quinto, contrato_ocs_295_2024).
clause_of(clausula_decima_oitava_penalidades_paragrafo_sexto, contrato_ocs_295_2024).
clause_of(clausula_decima_oitava_penalidades_paragrafo_setimo, contrato_ocs_295_2024).
clause_of(clausula_decima_oitava_penalidades_paragrafo_oitavo, contrato_ocs_295_2024).
clause_of(clausula_decima_nona_alteracoes_contratuais, contrato_ocs_295_2024).
clause_of(clausula_decima_nona_alteracoes_contratuais_paragrafo_segundo, contrato_ocs_295_2024).
clause_of(clausula_decima_nona_alteracoes_contratuais_paragrafo_terceiro, contrato_ocs_295_2024).
clause_of(clausula_vigesima_extincao_contrato, contrato_ocs_295_2024).
clause_of(clausula_vigesima_extincao_contrato_xi, contrato_ocs_295_2024).
clause_of(clausula_vigesima_primeira_disposicoes_finais, contrato_ocs_295_2024).
clause_of(clausula_decima_segunda_conduta_etica_contratado_bndes, contrato_ocs_295_2024).
clause_of(clausula_decima_terceira_sigilo_informacoes, contrato_ocs_295_2024).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, kryptus_seguranca_da_informacao_s_a, provide_cybersecurity_services).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_cybersecurity_services).
legal_relation_instance(clausula_primeira_objeto, right_to_action, kryptus_seguranca_da_informacao_s_a, receive_payment_for_services).
legal_relation_instance(clausula_segunda_vigencia, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, rescind_contract).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, give_notice_of_rescission).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, kryptus_seguranca_da_informacao_s_a, execute_contracted_object).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_execution_of_contracted_object).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, kryptus_seguranca_da_informacao_s_a, execute_services_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_price_reduction_indices).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, kryptus_seguranca_da_informacao_s_a, be_subject_to_price_reduction_indices).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_service_execution_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, kryptus_seguranca_da_informacao_s_a, be_subject_to_penalties).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_quinta_recebimento_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_sexta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_party).
legal_relation_instance(clausula_sexta_preco, right_to_action, kryptus_seguranca_da_informacao_s_a, receive_payment).
legal_relation_instance(clausula_sexta_preco, no_right_to_action, kryptus_seguranca_da_informacao_s_a, demand_full_payment_for_partial_execution).
legal_relation_instance(clausula_sexta_preco, duty_to_act, kryptus_seguranca_da_informacao_s_a, bear_cost_of_quantification_errors).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_payment).
legal_relation_instance(clausula_setima_pagamento, right_to_action, kryptus_seguranca_da_informacao_s_a, receive_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, kryptus_seguranca_da_informacao_s_a, present_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, kryptus_seguranca_da_informacao_s_a, comply_tax_legislation).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, reject_out_of_time_document).
legal_relation_instance(clausula_setima_pagamento, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_from_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, kryptus_seguranca_da_informacao_s_a, attach_regularity_certificates).
legal_relation_instance(clausula_setima_pagamento, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_payment_with_divergences).
legal_relation_instance(clausula_setima_pagamento, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_values_from_invoice).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, right_to_economic_financial_equilibrium).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, kryptus_seguranca_da_informacao_s_a, right_to_economic_financial_equilibrium).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, reajust_or_revise_prices).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, kryptus_seguranca_da_informacao_s_a, reajust_or_revise_prices).
legal_relation_instance(clausula_oitava_paragrafo_primeiro, power, kryptus_seguranca_da_informacao_s_a, request_price_adjustment).
legal_relation_instance(clausula_oitava_paragrafo_primeiro, duty_to_act, kryptus_seguranca_da_informacao_s_a, request_price_adjustment_every_12_months).
legal_relation_instance(clausula_oitava_paragrafo_segundo, duty_to_act, kryptus_seguranca_da_informacao_s_a, formulate_price_revision_request).
legal_relation_instance(clausula_oitava_paragrafo_segundo, duty_to_act, kryptus_seguranca_da_informacao_s_a, prove_generator_event_occurence).
legal_relation_instance(clausula_oitava_paragrafo_segundo, duty_to_act, kryptus_seguranca_da_informacao_s_a, present_cost_spreadsheets).
legal_relation_instance(clausula_oitava_paragrafo_segundo, permission_to_act, kryptus_seguranca_da_informacao_s_a, request_price_revision).
legal_relation_instance(clausula_oitava_paragrafo_segundo, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, revise_prices_bndes_initiative).
legal_relation_instance(clausula_oitava_paragrafo_terceiro, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, convocar_contratado_negociar_reducao_precos).
legal_relation_instance(clausula_oitava_paragrafo_terceiro, duty_to_act, kryptus_seguranca_da_informacao_s_a, apresentar_informacoes_solicitadas).
legal_relation_instance(clausula_oitava_paragrafo_terceiro, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, solicitar_informacoes_do_contratado).
legal_relation_instance(clausula_oitava_paragrafo_quarto, duty_to_act, kryptus_seguranca_da_informacao_s_a, request_price_adjustment).
legal_relation_instance(clausula_oitava_paragrafo_quarto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_price_adjustment_request).
legal_relation_instance(clausula_oitava_paragrafo_quarto, no_right_to_action, kryptus_seguranca_da_informacao_s_a, request_retroactive_price_adjustment).
legal_relation_instance(clausula_oitava_paragrafo_quarto, right_to_action, kryptus_seguranca_da_informacao_s_a, request_price_adjustment).
legal_relation_instance(clausula_oitava_paragrafo_quarto, duty_to_omit, kryptus_seguranca_da_informacao_s_a, request_retroactive_price_adjustment).
legal_relation_instance(clausula_oitava_paragrafo_quarto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_price_adjustment_request).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, identify_risks).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, establish_responsibilities).
legal_relation_instance(clausula_nona_paragrafo_primeiro, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, respect_economic_financial_balance_clause).
legal_relation_instance(clausula_nona_paragrafo_segundo, duty_to_omit, kryptus_seguranca_da_informacao_s_a, omit_celebration_of_additives).
legal_relation_instance(clausula_nona_paragrafo_segundo, no_right_to_action, kryptus_seguranca_da_informacao_s_a, no_right_to_celebrate_additives).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, kryptus_seguranca_da_informacao_s_a, provide_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, return_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_omit, kryptus_seguranca_da_informacao_s_a, omit_failure_to_provide_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalty_for_failure_to_provide_guarantee).
legal_relation_instance(clausula_decima_i_caucao_dinheiro, duty_to_act, kryptus_seguranca_da_informacao_s_a, deposit_money_in_favor_of_bndes).
legal_relation_instance(clausula_decima_i_caucao_dinheiro, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_money_deposit).
legal_relation_instance(clausula_decima_ii_seguro_garantia, duty_to_omit, kryptus_seguranca_da_informacao_s_a, omit_issuing_policy_under_fiscal_direction).
legal_relation_instance(clausula_decima_ii_seguro_garantia, duty_to_omit, kryptus_seguranca_da_informacao_s_a, omit_issuing_policy_if_under_susep_suspension).
legal_relation_instance(clausula_decima_ii_seguro_garantia, duty_to_act, kryptus_seguranca_da_informacao_s_a, issue_insurance_policy).
legal_relation_instance(clausula_decima_ii_a_o_instrumento_de_apolice_de_seguro_deve_prever_expressamente, duty_to_act, kryptus_seguranca_da_informacao_s_a, ensure_insurance_coverage_for_sanctioning_fines).
legal_relation_instance(clausula_decima_ii_a_o_instrumento_de_apolice_de_seguro_deve_prever_expressamente, duty_to_act, kryptus_seguranca_da_informacao_s_a, ensure_insurance_validity_for_contract_term).
legal_relation_instance(clausula_decima_ii_a_o_instrumento_de_apolice_de_seguro_deve_prever_expressamente, duty_to_act, kryptus_seguranca_da_informacao_s_a, provide_insurance_policy_instrument).
legal_relation_instance(clausula_decima_ii_a_o_instrumento_de_apolice_de_seguro_deve_prever_expressamente, duty_to_act, kryptus_seguranca_da_informacao_s_a, allow_90_day_period_to_assess_and_communicate_default).
legal_relation_instance(clausula_decima_iii_fianca_bancaria, disability, unknown, issue_bank_guarantee).
legal_relation_instance(clausula_decima_iii_fianca_bancaria, disability, unknown, issue_bank_guarantee_intervention).
legal_relation_instance(clausula_decima_iii_a_o_instrumento_de_fianca_deve_prever_expressamente, duty_to_act, kryptus_seguranca_da_informacao_s_a, communicate_inadimplemento).
legal_relation_instance(clausula_decima_iii_a_o_instrumento_de_fianca_deve_prever_expressamente, subjection, kryptus_seguranca_da_informacao_s_a, liability_for_inadimplemento).
legal_relation_instance(clausula_decima_paragrafo_primeiro, permission_to_act, kryptus_seguranca_da_informacao_s_a, request_extension_for_presenting_guarantee).
legal_relation_instance(clausula_decima_paragrafo_primeiro, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, accept_justified_extension_request).
legal_relation_instance(clausula_decima_paragrafo_primeiro, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, consider_extension_request).
legal_relation_instance(clausula_decima_paragrafo_segundo, permission_to_omit, kryptus_seguranca_da_informacao_s_a, omit_update_guarantee).
legal_relation_instance(clausula_decima_paragrafo_segundo, duty_to_act, kryptus_seguranca_da_informacao_s_a, update_guarantee).
legal_relation_instance(clausula_decima_paragrafo_terceiro, duty_to_act, kryptus_seguranca_da_informacao_s_a, provide_guarantee_complement).
legal_relation_instance(clausula_decima_paragrafo_terceiro, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, stipulate_guarantee_complement_term).
legal_relation_instance(clausula_decima_paragrafo_quarto, duty_to_act, kryptus_seguranca_da_informacao_s_a, obtain_guarantor_agreement).
legal_relation_instance(clausula_decima_paragrafo_quarto, duty_to_act, kryptus_seguranca_da_informacao_s_a, obtain_new_guarantee).
legal_relation_instance(clausula_decima_paragrafo_quarto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extend_guarantee_deadline).
legal_relation_instance(clausula_decima_paragrafo_quinto, duty_to_act, kryptus_seguranca_da_informacao_s_a, provide_contractual_guarantee).
legal_relation_instance(clausula_decima_paragrafo_quinto, subjection, kryptus_seguranca_da_informacao_s_a, pay_moratorium_penalties).
legal_relation_instance(clausula_decima_paragrafo_quinto, duty_to_act, kryptus_seguranca_da_informacao_s_a, fulfill_labor_obligations).
legal_relation_instance(clausula_decima_paragrafo_quinto, subjection, kryptus_seguranca_da_informacao_s_a, bear_liabilities_arising_from_contract).
legal_relation_instance(clausula_decima_paragrafo_quinto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_compensation_for_damages).
legal_relation_instance(clausula_decima_paragrafo_quinto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_compensation_for_losses_due_to_negligence).
legal_relation_instance(clausula_decima_paragrafo_quinto, subjection, kryptus_seguranca_da_informacao_s_a, bear_labor_obligations).
legal_relation_instance(clausula_decima_paragrafo_quinto, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, not_act_with_willful_misconduct).
legal_relation_instance(clausula_decima_paragrafo_sexto, duty_to_act, kryptus_seguranca_da_informacao_s_a, notify_guarantor_insurer).
legal_relation_instance(clausula_decima_paragrafo_sexto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_notification_from_contractor).
legal_relation_instance(clausula_decima_paragrafo_setimo, subjection, kryptus_seguranca_da_informacao_s_a, apply_law_13295_2024).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, kryptus_seguranca_da_informacao_s_a, maintain_conditions_of_habilitation).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, kryptus_seguranca_da_informacao_s_a, communicate_imposition_of_penalty).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, kryptus_seguranca_da_informacao_s_a, repair_correct_remove_reconstruct_or_substitute).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, kryptus_seguranca_da_informacao_s_a, repair_damages_and_losses).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, kryptus_seguranca_da_informacao_s_a, pay_charges_and_taxes).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, kryptus_seguranca_da_informacao_s_a, assume_responsibility_for_burdens).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, kryptus_seguranca_da_informacao_s_a, exclude_from_simples_nacional).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, kryptus_seguranca_da_informacao_s_a, allow_inspections).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, kryptus_seguranca_da_informacao_s_a, obey_instructions).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, kryptus_seguranca_da_informacao_s_a, designate_representative).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments_to_contracted).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager_substitute).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_info_available).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_administrative_procedure).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_penalty).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_contractor_access_to_ethical_docs).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alter_contract_manager).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, right_to_action, kryptus_seguranca_da_informacao_s_a, receive_payments_from_bndes).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, duty_to_act, kryptus_seguranca_da_informacao_s_a, prove_absence_of_discrimination).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_proof_of_no_discrimination).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_contract_execution).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, disability, kryptus_seguranca_da_informacao_s_a, cannot_prevent_suspension).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, duty_to_omit, kryptus_seguranca_da_informacao_s_a, omit_contract_cession).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, kryptus_seguranca_da_informacao_s_a, no_right_to_cede_contract).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, duty_to_omit, kryptus_seguranca_da_informacao_s_a, omit_credit_cession).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, kryptus_seguranca_da_informacao_s_a, no_right_to_cede_credit).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, duty_to_omit, kryptus_seguranca_da_informacao_s_a, omit_credit_title_emission).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, kryptus_seguranca_da_informacao_s_a, no_right_to_emit_credit_title).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, subjection, kryptus_seguranca_da_informacao_s_a, contracted_party_subject_to_bndes_acquiescence).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, duty_to_act, kryptus_seguranca_da_informacao_s_a, maintain_contract_conditions).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, permission_to_act, kryptus_seguranca_da_informacao_s_a, merge_split_incorporate).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_segundo, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, execute_contract).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_segundo, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_credits).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_terceiro, duty_to_omit, kryptus_seguranca_da_informacao_s_a, refrain_from_subcontracting).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_terceiro, no_right_to_action, kryptus_seguranca_da_informacao_s_a, subcontract_work).
legal_relation_instance(clausula_decima_oitava_penalidades, subjection, kryptus_seguranca_da_informacao_s_a, be_subject_to_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_credits).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_oitava_penalidades, right_to_action, kryptus_seguranca_da_informacao_s_a, request_reconsideration).
legal_relation_instance(clausula_decima_oitava_penalidades, right_to_action, kryptus_seguranca_da_informacao_s_a, interpose_appeal).
legal_relation_instance(clausula_decima_oitava_penalidades, duty_to_act, kryptus_seguranca_da_informacao_s_a, comply_with_bndes_requirements).
legal_relation_instance(clausula_decima_oitava_penalidades_paragrafo_quinto, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, judicial_recovery_of_difference).
legal_relation_instance(clausula_decima_oitava_penalidades_paragrafo_sexto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, observe_law_12846_2013).
legal_relation_instance(clausula_decima_oitava_penalidades_paragrafo_setimo, no_right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, no_right_to_omit_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades_paragrafo_setimo, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, duty_to_apply_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades_paragrafo_oitavo, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_sanction).
legal_relation_instance(clausula_decima_oitava_penalidades_paragrafo_oitavo, subjection, kryptus_seguranca_da_informacao_s_a, be_subject_to_sanction).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alter_contract).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, not_denature_object).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, denature_object).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_alteration).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, no_right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, refrain_from_refusing_formalization).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, preserve_economic_financial_equilibrium).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, refuse_formalization).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, permission_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, refuse_contract_alteration_formalization).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais_paragrafo_segundo, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, be_liable_for_damages).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais_paragrafo_segundo, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, promote_contract_alteration).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais_paragrafo_segundo, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_refusal_to_promote_alteration).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais_paragrafo_terceiro, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_changes_via_epistolary_means).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais_paragrafo_terceiro, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_changes_via_additive_instrument).
legal_relation_instance(clausula_vigesima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_consensually).
legal_relation_instance(clausula_vigesima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_contract_execution).
legal_relation_instance(clausula_vigesima_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_in_case_of_breach).
legal_relation_instance(clausula_vigesima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_for_lack_of_release).
legal_relation_instance(clausula_vigesima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_due_to_contractor_bankruptcy).
legal_relation_instance(clausula_vigesima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_due_to_loss_of_qualification).
legal_relation_instance(clausula_vigesima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_due_to_clause_breach).
legal_relation_instance(clausula_vigesima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_due_to_unfitness).
legal_relation_instance(clausula_vigesima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_due_to_suspension).
legal_relation_instance(clausula_vigesima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_due_to_harmful_act).
legal_relation_instance(clausula_vigesima_extincao_contrato_xi, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_vigesima_extincao_contrato_xi, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, give_written_notice).
legal_relation_instance(clausula_vigesima_extincao_contrato_xi, subjection, kryptus_seguranca_da_informacao_s_a, receive_termination_notice).
legal_relation_instance(clausula_vigesima_extincao_contrato_xi, right_to_action, kryptus_seguranca_da_informacao_s_a, present_defense).
legal_relation_instance(clausula_vigesima_primeira_disposicoes_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights).
legal_relation_instance(clausula_vigesima_primeira_disposicoes_finais, permission_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_strict_enforcement).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_omit, kryptus_seguranca_da_informacao_s_a, not_offer_bribe).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_omit, kryptus_seguranca_da_informacao_s_a, not_impede_bndes_employee_participation).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_omit, kryptus_seguranca_da_informacao_s_a, not_allocate_family_members).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, kryptus_seguranca_da_informacao_s_a, observe_related_party_policy).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, kryptus_seguranca_da_informacao_s_a, adopt_good_environmental_practices).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, kryptus_seguranca_da_informacao_s_a, inform_bndes_conflict_of_interest).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, kryptus_seguranca_da_informacao_s_a, notify_bndes_investigation).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, kryptus_seguranca_da_informacao_s_a, inform_bndes_violation_of_secrecy_rules).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, kryptus_seguranca_da_informacao_s_a, return_materials_to_bndes).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_omit, kryptus_seguranca_da_informacao_s_a, not_access_confidential_information).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_omit, kryptus_seguranca_da_informacao_s_a, divulge_confidential_info).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_returned_materials).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, kryptus_seguranca_da_informacao_s_a, present_confidentiality_terms).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, kryptus_seguranca_da_informacao_s_a, limit_access_to_info).

% --- Action catalog (local to this contract grounding) ---
action_type(accept_justified_extension_request).
action_label(accept_justified_extension_request, 'Accept extension request.').
action_type(adopt_good_environmental_practices).
action_label(adopt_good_environmental_practices, 'Adopt good environmental practices').
action_type(allow_90_day_period_to_assess_and_communicate_default).
action_label(allow_90_day_period_to_assess_and_communicate_default, 'Allow period to assess and communicate default').
action_type(allow_inspections).
action_label(allow_inspections, 'Allow inspections').
action_type(alter_contract).
action_label(alter_contract, 'Alter contract').
action_type(alter_contract_manager).
action_label(alter_contract_manager, 'Alter contract manager').
action_type(analyze_price_adjustment_request).
action_label(analyze_price_adjustment_request, 'Analyze price adjustment request').
action_type(apply_law_13295_2024).
action_label(apply_law_13295_2024, 'Subject to Law 13.303/2016').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_penalty_for_failure_to_provide_guarantee).
action_label(apply_penalty_for_failure_to_provide_guarantee, 'Apply penalty for failure to provide guarantee').
action_type(apply_price_reduction_indices).
action_label(apply_price_reduction_indices, 'Apply price reduction indices').
action_type(apply_sanction).
action_label(apply_sanction, 'Apply sanction').
action_type(apresentar_informacoes_solicitadas).
action_label(apresentar_informacoes_solicitadas, 'Present requested information').
action_type(assume_responsibility_for_burdens).
action_label(assume_responsibility_for_burdens, 'Assume responsibility for burdens').
action_type(attach_regularity_certificates).
action_label(attach_regularity_certificates, 'Attach regularity certificates').
action_type(be_liable_for_damages).
action_label(be_liable_for_damages, 'Be liable for damages').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Be subject to penalties').
action_type(be_subject_to_price_reduction_indices).
action_label(be_subject_to_price_reduction_indices, 'Be subject to price reduction').
action_type(be_subject_to_sanction).
action_label(be_subject_to_sanction, 'Subject to sanction').
action_type(bear_cost_of_quantification_errors).
action_label(bear_cost_of_quantification_errors, 'Bear cost of quantification errors').
action_type(bear_labor_obligations).
action_label(bear_labor_obligations, 'Bear labor obligations').
action_type(bear_liabilities_arising_from_contract).
action_label(bear_liabilities_arising_from_contract, 'Bear liabilities from contract').
action_type(cannot_prevent_suspension).
action_label(cannot_prevent_suspension, 'Cannot prevent suspension').
action_type(carry_out_inspections).
action_label(carry_out_inspections, 'Carry out inspections').
action_type(communicate_administrative_procedure).
action_label(communicate_administrative_procedure, 'Communicate administrative procedure').
action_type(communicate_imposition_of_penalty).
action_label(communicate_imposition_of_penalty, 'Communicate penalty').
action_type(communicate_inadimplemento).
action_label(communicate_inadimplemento, 'Communicate default').
action_type(communicate_instructions).
action_label(communicate_instructions, 'Communicate instructions').
action_type(communicate_penalty).
action_label(communicate_penalty, 'Communicate penalty').
action_type(comply_tax_legislation).
action_label(comply_tax_legislation, 'Comply with tax legislation').
action_type(comply_with_bndes_requirements).
action_label(comply_with_bndes_requirements, 'Comply with BNDES requirements').
action_type(consider_extension_request).
action_label(consider_extension_request, 'Consider extension request.').
action_type(contracted_party_subject_to_bndes_acquiescence).
action_label(contracted_party_subject_to_bndes_acquiescence, 'Subject to BNDES acquiescence').
action_type(convocar_contratado_negociar_reducao_precos).
action_label(convocar_contratado_negociar_reducao_precos, 'Call contractor to negotiate price reduction').
action_type(deduct_credits).
action_label(deduct_credits, 'Deduct credits').
action_type(deduct_from_payment).
action_label(deduct_from_payment, 'Deduct from payment').
action_type(deduct_values_from_invoice).
action_label(deduct_values_from_invoice, 'Deduct values from invoice').
action_type(demand_contractual_guarantee).
action_label(demand_contractual_guarantee, 'Demand contractual guarantee').
action_type(demand_full_payment_for_partial_execution).
action_label(demand_full_payment_for_partial_execution, 'Demand full payment for partial execution').
action_type(demand_proof_of_regularity).
action_label(demand_proof_of_regularity, 'Demand proof of regularity').
action_type(demand_service_execution_standards).
action_label(demand_service_execution_standards, 'Demand service execution standards').
action_type(denature_object).
action_label(denature_object, 'Denature object').
action_type(deposit_money_in_favor_of_bndes).
action_label(deposit_money_in_favor_of_bndes, 'Deposit money with BNDES').
action_type(designate_contract_manager).
action_label(designate_contract_manager, 'Designate contract manager').
action_type(designate_contract_manager_substitute).
action_label(designate_contract_manager_substitute, 'Designate contract manager substitute').
action_type(designate_representative).
action_label(designate_representative, 'Designate representative').
action_type(divulge_confidential_info).
action_label(divulge_confidential_info, 'Do not divulge confidential info').
action_type(duty_to_apply_penalties).
action_label(duty_to_apply_penalties, 'Duty to apply penalties').
action_type(effect_object_receipt).
action_label(effect_object_receipt, 'Effect object receipt').
action_type(effect_payment).
action_label(effect_payment, 'Effect payment').
action_type(ensure_insurance_coverage_for_sanctioning_fines).
action_label(ensure_insurance_coverage_for_sanctioning_fines, 'Ensure coverage for sanctioning fines').
action_type(ensure_insurance_validity_for_contract_term).
action_label(ensure_insurance_validity_for_contract_term, 'Ensure validity for contract term').
action_type(establish_responsibilities).
action_label(establish_responsibilities, 'Establish responsibilities').
action_type(exclude_from_simples_nacional).
action_label(exclude_from_simples_nacional, 'Exclude from Simples Nacional').
action_type(execute_contract).
action_label(execute_contract, 'Execute the contract').
action_type(execute_contracted_object).
action_label(execute_contracted_object, 'Execute the object of the contract').
action_type(execute_services_according_to_standards).
action_label(execute_services_according_to_standards, 'Execute services according to standards').
action_type(exercise_rights).
action_label(exercise_rights, 'Exercise rights').
action_type(expect_execution_of_contracted_object).
action_label(expect_execution_of_contracted_object, 'Expect execution of contracted object').
action_type(extend_guarantee_deadline).
action_label(extend_guarantee_deadline, 'Extend guarantee deadline').
action_type(formalize_contract_alteration).
action_label(formalize_contract_alteration, 'Formalize contract alteration').
action_type(formalize_contract_changes_via_additive_instrument).
action_label(formalize_contract_changes_via_additive_instrument, 'Formalize contract changes via instrument').
action_type(formalize_contract_changes_via_epistolary_means).
action_label(formalize_contract_changes_via_epistolary_means, 'Formalize contract changes via letter').
action_type(formulate_price_revision_request).
action_label(formulate_price_revision_request, 'Formulate price revision request').
action_type(fulfill_labor_obligations).
action_label(fulfill_labor_obligations, 'Fulfill labor obligations').
action_type(give_notice_of_rescission).
action_label(give_notice_of_rescission, 'Give notice of rescission').
action_type(give_written_notice).
action_label(give_written_notice, 'Give written notice').
action_type(identify_risks).
action_label(identify_risks, 'Identify risks').
action_type(inform_bndes_conflict_of_interest).
action_label(inform_bndes_conflict_of_interest, 'Inform BNDES of conflict of interest').
action_type(inform_bndes_violation_of_secrecy_rules).
action_label(inform_bndes_violation_of_secrecy_rules, 'Inform BNDES of secrecy rule violations.').
action_type(interpose_appeal).
action_label(interpose_appeal, 'Interpose appeal').
action_type(issue_bank_guarantee).
action_label(issue_bank_guarantee, 'Cannot issue bank guarantee if in liquidation').
action_type(issue_bank_guarantee_intervention).
action_label(issue_bank_guarantee_intervention, 'Cannot issue bank guarantee if under BACEN intervention').
action_type(issue_insurance_policy).
action_label(issue_insurance_policy, 'Issue insurance policy').
action_type(judicial_recovery_of_difference).
action_label(judicial_recovery_of_difference, 'Judicial recovery of difference').
action_type(liability_for_inadimplemento).
action_label(liability_for_inadimplemento, 'Liability for default').
action_type(limit_access_to_info).
action_label(limit_access_to_info, 'Limit access to information.').
action_type(maintain_conditions_of_habilitation).
action_label(maintain_conditions_of_habilitation, 'Maintain conditions of habilitation').
action_type(maintain_contract_conditions).
action_label(maintain_contract_conditions, 'Maintain conditions').
action_type(make_info_available).
action_label(make_info_available, 'Provide necessary information').
action_type(make_payments_to_contracted).
action_label(make_payments_to_contracted, 'Make payments to contractor').
action_type(merge_split_incorporate).
action_label(merge_split_incorporate, 'Merge/split/incorporate').
action_type(no_right_to_cede_contract).
action_label(no_right_to_cede_contract, 'No right to cede contract').
action_type(no_right_to_cede_credit).
action_label(no_right_to_cede_credit, 'No right to cede credit').
action_type(no_right_to_celebrate_additives).
action_label(no_right_to_celebrate_additives, 'No right to celebrate additives').
action_type(no_right_to_emit_credit_title).
action_label(no_right_to_emit_credit_title, 'No right to emit credit title').
action_type(no_right_to_omit_penalties).
action_label(no_right_to_omit_penalties, 'No right to omit penalties').
action_type(not_access_confidential_information).
action_label(not_access_confidential_information, 'Do not access confidential information.').
action_type(not_act_with_willful_misconduct).
action_label(not_act_with_willful_misconduct, 'Not act with misconduct').
action_type(not_allocate_family_members).
action_label(not_allocate_family_members, 'Not allocate family members').
action_type(not_denature_object).
action_label(not_denature_object, 'Do not denature object').
action_type(not_impede_bndes_employee_participation).
action_label(not_impede_bndes_employee_participation, 'Not impede BNDES employee participation').
action_type(not_offer_bribe).
action_label(not_offer_bribe, 'Not offer bribe').
action_type(notify_bndes_investigation).
action_label(notify_bndes_investigation, 'Notify BNDES of investigation').
action_type(notify_guarantor_insurer).
action_label(notify_guarantor_insurer, 'Notify guarantor/insurer').
action_type(notify_in_case_of_breach).
action_label(notify_in_case_of_breach, 'Notify breach').
action_type(obey_instructions).
action_label(obey_instructions, 'Obey instructions').
action_type(observe_law_12846_2013).
action_label(observe_law_12846_2013, 'Observe Law 12.846/2013').
action_type(observe_related_party_policy).
action_label(observe_related_party_policy, 'Observe related party policy').
action_type(obtain_guarantor_agreement).
action_label(obtain_guarantor_agreement, 'Obtain guarantor\'s agreement').
action_type(obtain_new_guarantee).
action_label(obtain_new_guarantee, 'Obtain new guarantee').
action_type(omit_celebration_of_additives).
action_label(omit_celebration_of_additives, 'Omit celebration of additives').
action_type(omit_contract_cession).
action_label(omit_contract_cession, 'Omit contract cession').
action_type(omit_credit_cession).
action_label(omit_credit_cession, 'Omit credit cession').
action_type(omit_credit_title_emission).
action_label(omit_credit_title_emission, 'Omit credit title emission').
action_type(omit_failure_to_provide_guarantee).
action_label(omit_failure_to_provide_guarantee, 'Omit failure to provide guarantee').
action_type(omit_issuing_policy_if_under_susep_suspension).
action_label(omit_issuing_policy_if_under_susep_suspension, 'Omit policy if under SUSEP suspension').
action_type(omit_issuing_policy_under_fiscal_direction).
action_label(omit_issuing_policy_under_fiscal_direction, 'Omit issuing policy under fiscal direction').
action_type(omit_payment_with_divergences).
action_label(omit_payment_with_divergences, 'Omit payment with divergences').
action_type(omit_refusal_to_promote_alteration).
action_label(omit_refusal_to_promote_alteration, 'Omit refusing alteration').
action_type(omit_strict_enforcement).
action_label(omit_strict_enforcement, 'Omit strict enforcement').
action_type(omit_update_guarantee).
action_label(omit_update_guarantee, 'Omit guarantee update').
action_type(pay_charges_and_taxes).
action_label(pay_charges_and_taxes, 'Pay charges and taxes').
action_type(pay_contracted_party).
action_label(pay_contracted_party, 'Pay contracted party').
action_type(pay_moratorium_penalties).
action_label(pay_moratorium_penalties, 'Pay penalties').
action_type(present_confidentiality_terms).
action_label(present_confidentiality_terms, 'Present Confidentiality Terms.').
action_type(present_cost_spreadsheets).
action_label(present_cost_spreadsheets, 'Present cost spreadsheets').
action_type(present_defense).
action_label(present_defense, 'Present a defense').
action_type(present_dif).
action_label(present_dif, 'Present DIF').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(preserve_economic_financial_equilibrium).
action_label(preserve_economic_financial_equilibrium, 'Preserve equilibrium').
action_type(promote_contract_alteration).
action_label(promote_contract_alteration, 'Promote contract alteration').
action_type(prove_absence_of_discrimination).
action_label(prove_absence_of_discrimination, 'Prove absence of discrimination').
action_type(prove_generator_event_occurence).
action_label(prove_generator_event_occurence, 'Prove generator event occurence').
action_type(provide_contractor_access_to_ethical_docs).
action_label(provide_contractor_access_to_ethical_docs, 'Provide contractor access to ethical documents').
action_type(provide_contractual_guarantee).
action_label(provide_contractual_guarantee, 'Provide contractual guarantee').
action_type(provide_cybersecurity_services).
action_label(provide_cybersecurity_services, 'Provide cybersecurity services').
action_type(provide_guarantee_complement).
action_label(provide_guarantee_complement, 'Provide guarantee complement').
action_type(provide_information_for_risk_management).
action_label(provide_information_for_risk_management, 'Provide information for risk management').
action_type(provide_insurance_policy_instrument).
action_label(provide_insurance_policy_instrument, 'Provide insurance policy instrument').
action_type(reajust_or_revise_prices).
action_label(reajust_or_revise_prices, 'Reajust or revise prices').
action_type(receive_compensation_for_damages).
action_label(receive_compensation_for_damages, 'Receive compensation').
action_type(receive_compensation_for_losses_due_to_negligence).
action_label(receive_compensation_for_losses_due_to_negligence, 'Receive compensation for losses').
action_type(receive_credits).
action_label(receive_credits, 'Receive credits').
action_type(receive_cybersecurity_services).
action_label(receive_cybersecurity_services, 'Receive cybersecurity services').
action_type(receive_money_deposit).
action_label(receive_money_deposit, 'Receive money deposit').
action_type(receive_notification_from_contractor).
action_label(receive_notification_from_contractor, 'Receive notification').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payment_for_services).
action_label(receive_payment_for_services, 'Receive payment for services').
action_type(receive_payments_from_bndes).
action_label(receive_payments_from_bndes, 'Receive payments from BNDES').
action_type(receive_returned_materials).
action_label(receive_returned_materials, 'Receive returned materials.').
action_type(receive_termination_notice).
action_label(receive_termination_notice, 'Receive termination notice').
action_type(refrain_from_refusing_formalization).
action_label(refrain_from_refusing_formalization, 'Refrain from refusing formalization').
action_type(refrain_from_subcontracting).
action_label(refrain_from_subcontracting, 'Refrain from subcontracting').
action_type(refuse_contract_alteration_formalization).
action_label(refuse_contract_alteration_formalization, 'Refuse alteration formalization').
action_type(refuse_formalization).
action_label(refuse_formalization, 'Refuse formalization').
action_type(reject_out_of_time_document).
action_label(reject_out_of_time_document, 'Reject out of time document').
action_type(repair_correct_remove_reconstruct_or_substitute).
action_label(repair_correct_remove_reconstruct_or_substitute, 'Repair defects').
action_type(repair_damages_and_losses).
action_label(repair_damages_and_losses, 'Repair damages and losses').
action_type(request_extension_for_presenting_guarantee).
action_label(request_extension_for_presenting_guarantee, 'Request extension to present guarantee.').
action_type(request_price_adjustment).
action_label(request_price_adjustment, 'Request price adjustment').
action_type(request_price_adjustment_every_12_months).
action_label(request_price_adjustment_every_12_months, 'Request adjustment every 12 months').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(request_proof_of_no_discrimination).
action_label(request_proof_of_no_discrimination, 'Request proof of no discrimination').
action_type(request_reconsideration).
action_label(request_reconsideration, 'Request reconsideration').
action_type(request_retroactive_price_adjustment).
action_label(request_retroactive_price_adjustment, 'Omit request for retroactive effects').
action_type(rescind_contract).
action_label(rescind_contract, 'Rescind contract').
action_type(respect_economic_financial_balance_clause).
action_label(respect_economic_financial_balance_clause, 'Respect economic balance clause').
action_type(return_guarantee).
action_label(return_guarantee, 'Return guarantee').
action_type(return_materials_to_bndes).
action_label(return_materials_to_bndes, 'Return materials to BNDES.').
action_type(revise_prices_bndes_initiative).
action_label(revise_prices_bndes_initiative, 'Revise prices (BNDES initiative)').
action_type(right_to_economic_financial_equilibrium).
action_label(right_to_economic_financial_equilibrium, 'Right to economic-financial balance').
action_type(solicitar_informacoes_do_contratado).
action_label(solicitar_informacoes_do_contratado, 'Request information from contractor').
action_type(stipulate_guarantee_complement_term).
action_label(stipulate_guarantee_complement_term, 'Stipulate guarantee term').
action_type(subcontract_work).
action_label(subcontract_work, 'No right to subcontract').
action_type(suspend_contract_execution).
action_label(suspend_contract_execution, 'Suspend contract execution').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').
action_type(terminate_contract_consensually).
action_label(terminate_contract_consensually, 'Terminate consensually').
action_type(terminate_due_to_clause_breach).
action_label(terminate_due_to_clause_breach, 'Terminate due to clause breach').
action_type(terminate_due_to_contractor_bankruptcy).
action_label(terminate_due_to_contractor_bankruptcy, 'Terminate due to contractor bankruptcy').
action_type(terminate_due_to_harmful_act).
action_label(terminate_due_to_harmful_act, 'Terminate due to harmful act').
action_type(terminate_due_to_loss_of_qualification).
action_label(terminate_due_to_loss_of_qualification, 'Terminate due to loss of qualification').
action_type(terminate_due_to_suspension).
action_label(terminate_due_to_suspension, 'Terminate due to suspension').
action_type(terminate_due_to_unfitness).
action_label(terminate_due_to_unfitness, 'Terminate due to unfitness').
action_type(terminate_for_lack_of_release).
action_label(terminate_for_lack_of_release, 'Terminate for lack of release').
action_type(update_guarantee).
action_label(update_guarantee, 'Update guarantee').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_295_2024).
contract_metadata(contrato_ocs_295_2024, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_295_2024, regulamento, 'Regulamento Licitações e Contratos do Sistema BNDES').
contract_metadata_raw(contrato_ocs_295_2024, 'Classificação', 'Documento Ostensivo', 'Lei nº 13.303/2016').
contract_metadata_raw(contrato_ocs_295_2024, 'Unidade Gestora', 'AJI/JULIC/GLIC4', 'trecho_literal').
contract_metadata_raw(contrato_ocs_295_2024, 'CONTRATO OCS Nº', '295/2024', 'trecho_literal').
contract_metadata_raw(contrato_ocs_295_2024, 'CONTRATO SAP Nº', '4400006064', 'trecho_literal').
contract_metadata(contrato_ocs_295_2024, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇOS').
contract_metadata(contrato_ocs_295_2024, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'KRYPTUS SEGURANÇA DA INFORMAÇÃO S.A.']).
contract_metadata(contrato_ocs_295_2024, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_295_2024, contratado, 'KRYPTUS SEGURANÇA DA INFORMAÇÃO S.A.').
contract_metadata(contrato_ocs_295_2024, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_295_2024, cnpj_contratado, '05.761.098/0001-13').
contract_metadata(contrato_ocs_295_2024, procedimento_licitatorio, 'Pregão Eletrônico nº 007/2024 - BNDES').
contract_metadata(contrato_ocs_295_2024, data_autorizacao, '22/04/2024').
contract_metadata_raw(contrato_ocs_295_2024, 'IP AIC/DEROP nº', '01/2024', 'trecho_literal').
contract_metadata(contrato_ocs_295_2024, data_ip_ati_degat, '17/04/2024').
contract_metadata(contrato_ocs_295_2024, rubrica_orcamentaria, '3101700040').
contract_metadata(contrato_ocs_295_2024, centro_custo, 'BN00004000').
contract_metadata_raw(contrato_ocs_295_2024, 'Contrato OCS nº', '295/2024', 'preamble').
contract_metadata(contrato_ocs_295_2024, contratante, 'BNDES', 'preamble').
contract_metadata(contrato_ocs_295_2024, contratado, 'KRYPTUS SEGURANÇA DA INFORMAÇÃO S.A.', 'preamble').
contract_metadata_raw(contrato_ocs_295_2024, 'Classificação', 'Documento Ostensivo (Lei nº 13.303/2016)', 'preamble').
contract_metadata_raw(contrato_ocs_295_2024, 'Unidade Gestora', 'AJI/JULIC/GLIC4', 'preamble').
contract_clause(contrato_ocs_295_2024, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO \nO presente Contrato tem por objeto a prestação de serviços continuados, sem \ndedicação exclusiva de mão-de-obra, especializados em segurança cibernética \nprestado  por  Centro  de  Operações  de  Segurança  Cibernética  (Cyber  Security \nOperation  Center  –  CSOC)  para  o  Banco  Nacional  de  Desenvolvimento \nEconômico  e  Social  –  BNDES,  conforme  especificações  constantes  do  Termo \nde Referência (Anexo I do Edital do Pregão Eletrônico nº 07/2024 - BNDES) e \nda proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II \ndeste Contrato.', 'O presente Contrato tem por objeto a prestação de serviços continuados, sem \ndedicação exclusiva de mão-de-obra, especializados em segurança cibernética \nprestado  por  Centro  de  Operações  de  Segurança  Cibernética  (Cyber  Security \nOperation  Center  –  CSOC)  para  o  Banco  Nacional  de  Desenvolvimento \nEconômico  e  Social  –  BNDES,  conforme  especificações  constantes  do  Termo \nde Referência (Anexo I do Edital do Pregão Eletrônico nº 07/2024 - BNDES) e \nda proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II \ndeste Contrato.').
contract_clause(contrato_ocs_295_2024, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA \nO prazo de vigência do presente Contrato será de até 60 (sessenta) meses a \ncontar da data de sua assinatura, sendo de: \n\nI.    até  6  (seis)  meses,  contados  da  assinatura  do  contrato,  para  execução  da \nimplantação, incluindo todas as fases até a emissão do Termo de Recebimento \nDefinitivo; \nII.  até  60  (sessenta)  meses  a  contar  da  emissão  do  Termo  de  Recebimento \nDefinitivo, com opção de rescisão por parte do BNDES a partir do 30º (trigésimo) \nmês  de  vigência,  desde  que  comunicada  com  antecedência  de  180  (cento  e \noitenta) dias.', 'O prazo de vigência do presente Contrato será de até 60 (sessenta) meses a \ncontar da data de sua assinatura, sendo de: \n\nI.    até  6  (seis)  meses,  contados  da  assinatura  do  contrato,  para  execução  da \nimplantação, incluindo todas as fases até a emissão do Termo de Recebimento \nDefinitivo; \nII.  até  60  (sessenta)  meses  a  contar  da  emissão  do  Termo  de  Recebimento \nDefinitivo, com opção de rescisão por parte do BNDES a partir do 30º (trigésimo) \nmês  de  vigência,  desde  que  comunicada  com  antecedência  de  180  (cento  e \noitenta) dias.').
contract_clause(contrato_ocs_295_2024, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA  TERCEIRA  –  LOCAL,  PRAZO  E  CONDIÇÕES  DE  EXECUÇÃO \nDO OBJETO  \nA  execução  do  objeto  contratado  respeitará  as  especificações  constantes  do \nTermo  de  Referência  e  da  proposta  apresentada  pelo  CONTRATADO, \nrespectivamente, Anexos I e II deste Contrato.', 'A  execução  do  objeto  contratado  respeitará  as  especificações  constantes  do \nTermo  de  Referência  e  da  proposta  apresentada  pelo  CONTRATADO, \nrespectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_295_2024, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO  \nOs serviços contratados deverão ser executados de acordo com os padrões de \nqualidade, disponibilidade e desempenho estipulados pelo BNDES, observados \nos níveis de serviço descritos no Anexo I (Termo de Referência) deste Contrato. \n\nParágrafo Único \nO descumprimento dos níveis de serviço acarretará a aplicação dos índices de \nredução do preço previstos no Anexo I (Termo de Referência) deste Contrato, \nsem  prejuízo  da  aplicação  das  penalidades  previstas  neste  Contrato,  quando \ncabíveis.', 'Os serviços contratados deverão ser executados de acordo com os padrões de \nqualidade, disponibilidade e desempenho estipulados pelo BNDES, observados \nos níveis de serviço descritos no Anexo I (Termo de Referência) deste Contrato. \n\nParágrafo Único \nO descumprimento dos níveis de serviço acarretará a aplicação dos índices de \nredução do preço previstos no Anexo I (Termo de Referência) deste Contrato, \nsem  prejuízo  da  aplicação  das  penalidades  previstas  neste  Contrato,  quando \ncabíveis.').
contract_clause(contrato_ocs_295_2024, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO \nO  BNDES  efetuará  o  recebimento  do  objeto,  através  do  Gestor  do  Contrato, \nmencionados na Cláusula de Obrigações do BNDES deste Contrato, observado \no disposto no Anexo I (Termo de Referência) deste Contrato.', 'O  BNDES  efetuará  o  recebimento  do  objeto,  através  do  Gestor  do  Contrato, \nmencionados na Cláusula de Obrigações do BNDES deste Contrato, observado \no disposto no Anexo I (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_295_2024, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO  \nO  BNDES  pagará  ao  CONTRATADO,  pela  execução  do  objeto  contratado,  o \nvalor  de  até  R$  6.989.822,00  (seis  milhões,  novecentos  e  oitenta  e  nove  mil, \noitocentos e vinte e dois reais), conforme proposta apresentada (Anexo II deste \nContrato), observado o disposto na Cláusula de Pagamento deste Instrumento. \n\nContrato OCS nº 295/2024 \nContratante: BNDES \nContratado: KRYPTUS SEGURANÇA DA INFORMAÇÃO S.A. \n\n2                                                                                                                             \n\n \n \n \n \n \n \n \n \n \n \n\nClassificação: Documento Ostensivo (Lei nº 13.303/2016) \nUnidade Gestora: AJI/JULIC/GLIC4 \n\nParágrafo Primeiro \nNo  valor  ajustado  no  caput  desta  Cláusula  estão  incluídos  todos  os  insumos, \nencargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem \ncomo quaisquer outras despesas necessárias à execução deste Contrato. \n\nParágrafo Segundo \nNa  hipótese  de  o  objeto  ser,  a  critério  do  BNDES,  parcialmente  executado  e \nrecebido,  os  valores  previstos  nesta  Cláusula  serão  proporcionalmente \nreduzidos, sem prejuízo da aplicação das penalidades cabíveis. \n\nParágrafo Terceiro \nCaso o BNDES não demande o total do objeto previsto neste Contrato, não será \ndevida indenização ao CONTRATADO.  \n\nParágrafo Quarto \nO CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco \nno dimensionamento dos quantitativos de sua proposta, devendo complementá-\nlos,  caso  os  quantitativos  previstos  inicialmente  em  sua  proposta  não  sejam \nsatisfatórios para o atendimento ao objeto deste Contrato;  \n\nParágrafo Quinto \nO  BNDES  não  se  compromete  à  utilização  do  total  estimado  de  horas \nextraordinárias,  sendo  pagas  somente  as  que  efetivamente  forem  realizadas, \nque  serão  aferidas através  de  planilhas  a  serem apresentadas, mensalmente, \npelo CONTRATADO.', 'O  BNDES  pagará  ao  CONTRATADO,  pela  execução  do  objeto  contratado,  o \nvalor  de  até  R$  6.989.822,00  (seis  milhões,  novecentos  e  oitenta  e  nove  mil, \noitocentos e vinte e dois reais), conforme proposta apresentada (Anexo II deste \nContrato), observado o disposto na Cláusula de Pagamento deste Instrumento. \n\nContrato OCS nº 295/2024 \nContratante: BNDES \nContratado: KRYPTUS SEGURANÇA DA INFORMAÇÃO S.A. \n\n2                                                                                                                             \n\n \n \n \n \n \n \n \n \n \n \n\nClassificação: Documento Ostensivo (Lei nº 13.303/2016) \nUnidade Gestora: AJI/JULIC/GLIC4 \n\nParágrafo Primeiro \nNo  valor  ajustado  no  caput  desta  Cláusula  estão  incluídos  todos  os  insumos, \nencargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem \ncomo quaisquer outras despesas necessárias à execução deste Contrato. \n\nParágrafo Segundo \nNa  hipótese  de  o  objeto  ser,  a  critério  do  BNDES,  parcialmente  executado  e \nrecebido,  os  valores  previstos  nesta  Cláusula  serão  proporcionalmente \nreduzidos, sem prejuízo da aplicação das penalidades cabíveis. \n\nParágrafo Terceiro \nCaso o BNDES não demande o total do objeto previsto neste Contrato, não será \ndevida indenização ao CONTRATADO.  \n\nParágrafo Quarto \nO CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco \nno dimensionamento dos quantitativos de sua proposta, devendo complementá-\nlos,  caso  os  quantitativos  previstos  inicialmente  em  sua  proposta  não  sejam \nsatisfatórios para o atendimento ao objeto deste Contrato;  \n\nParágrafo Quinto \nO  BNDES  não  se  compromete  à  utilização  do  total  estimado  de  horas \nextraordinárias,  sendo  pagas  somente  as  que  efetivamente  forem  realizadas, \nque  serão  aferidas através  de  planilhas  a  serem apresentadas, mensalmente, \npelo CONTRATADO.').
contract_metadata_raw(contrato_ocs_295_2024, 'Contratante', 'BNDES', 'preamble').
contract_metadata_raw(contrato_ocs_295_2024, 'Contratado', 'KRYPTUS SEGURANÇA DA INFORMAÇÃO S.A.', 'preamble').
contract_clause(contrato_ocs_295_2024, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O  BNDES  efetuará  o  pagamento  referente  ao  objeto  deste  Contrato, \nmensalmente, por meio de crédito em conta bancária, em até 10 (dez) dias úteis, \na  contar  da  data  de  apresentação  do  documento  fiscal  ou  equivalente  legal \n(prioritariamente    nota  fiscal,  e  nos  casos  de  dispensa  da  nota  fiscal:  fatura, \nboleto bancário com código de barras, recibo de pagamento a autônomo), desde \nque  tenha  sido  efetuado  o  ateste  pelo  Gestor  do  Contrato  das  obrigações \ncontratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I \n(Termo de Referência) deste Instrumento.\n\nParágrafo Primeiro \nO documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no \nmês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior \nque  viabilize  o  tempestivo  recolhimento  de  ISS  possibilitando  o  cumprimento, \npelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste \nContrato.  Havendo  impedimento  legal  para  o  cumprimento  desse  prazo,  o\n\nContrato OCS nº 295/2024 \nContratante: BNDES \nContratado: KRYPTUS SEGURANÇA DA INFORMAÇÃO S.A. \n\n3                                                                                                                             \n\n \n \n \n \n \n \n \nClassificação: Documento Ostensivo (Lei nº 13.303/2016) \nUnidade Gestora: AJI/JULIC/GLIC4 \n\ndocumento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia \nútil do mês seguinte, seguinte da prestação do serviço/fornecimento do bem.\n\nParágrafo Segundo \nA apresentação do documento de cobrança fora do prazo previsto nesta cláusula \npoderá  implicar  em  sua  rejeição  e  no  direito  do  BNDES  se  ressarcir, \npreferencialmente, mediante desconto do valor a ser pago ao CONTRATADO, \npor qualquer penalidade tributária incidente pelo atraso.\n\nParágrafo Terceiro \nO primeiro documento fiscal ou equivalente legal terá como objeto de cobrança \no período compreendido entre o dia de início da prestação dos serviços e o último \ndia  desse  mês,  e  os  documentos  fiscais  ou  equivalentes  legais  subsequentes \nterão como referência o período compreendido entre o primeiro e o último dia de \ncada mês. O último documento fiscal ou equivalente legal, por seu turno, referir-\nse-á ao período compreendido entre o primeiro dia do último mês da prestação \ndos serviços e o último dia de serviço prestado. Em todos os casos, o documento \nfiscal ou equivalente legal só poderá ser emitido e apresentado ao BNDES após \na efetiva prestação do serviço, respeitado o disposto no Parágrafo anterior.\n\nParágrafo Quarto \nPara  toda  efetivação  de  pagamento,  o  Contratado  deverá  encaminhar  o \ndocumento fiscal ou equivalente em meio digital para caixa postal eletrônica ou \nprotocolar  em  sistema  eletrônico  próprio  do  BNDES,  considerando  as \norientações  do  Contratante  vigentes  na  ocasião  do  pagamento.  No  caso  de \nemissão de documento fiscal exclusivamente em meio físico o mesmo deverá \nser encaminhado ao protocolo do BNDES para devido registro de recebimento.\n\nParágrafo Quinto \nO documento fiscal ou equivalente legal deverá respeitar a legislação tributária \ne conter, minimamente, as seguintes informações: \n\nI.  número da Ordem de Compra/Serviço – OCS; \nII.  número SAP do Contrato; \nIII.  número do pedido SAP, a ser informado pelo Gestor do Contrato; \nIV.  número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor \ndo Contrato; \nV.  descrição detalhada do objeto executado e dos respectivos valores; \nVI.  período de referência da execução do objeto; \nVII. nome e número do CNPJ  do CONTRATADO, cuja regularidade fiscal tenha \nsido  avaliada  na  fase  de  habilitação,  bem  como  o  número  de  inscrição  na \nFazenda Municipal e/ou Estadual, conforme o caso; \nVIII. \nequivalente legal; \n\nContrato OCS nº 295/2024 \nContratante: BNDES \nContratado: KRYPTUS SEGURANÇA DA INFORMAÇÃO S.A. \n\n4                                                                                                                             \n\n \n \n \n \nClassificação: Documento Ostensivo (Lei nº 13.303/2016) \nUnidade Gestora: AJI/JULIC/GLIC4 \n\nnome,  telefone  e  e-mail  do  responsável  pelo  documento  fiscal  ou \n\ntomador  do  serviço:  Banco  Nacional  de  Desenvolvimento  Econômico  e \nIX.  nome  e  número  do  banco  e  da  agência,  bem  como  o  número  da  conta \ncorrente da CONTRATADO, vinculada ao CNPJ constante do documento fiscal \nou equivalente legal, com respectivos dígitos verificadores; \nX. \nSocial – BNDES; \nXI.  CNPJ do tomador do serviço: 33.657.248/0001-89; \nXII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente \nlegal para cada Município em que o serviço seja prestado, se for o caso;  \ncódigo  do  serviço,  nos  termos  da  lista  anexa  à  Lei  Complementar  nº \nXIII. \n116/2003,  em  concordância  com  as  informações  inseridas  na  Declaração  de \nInformações para Fornecimento - DIF; e  \nXIV.  destaque das retenções tributárias aplicáveis, conforme estabelecido na \nDIF.  \n\nParágrafo Sexto \nOs pagamentos a serem efetuados em favor do CONTRATADO estarão sujeitos, \nno  que  couber,  às  retenções  de  tributos, nos  termos  da  legislação  tributária  e \ncom  base  nas  informações  prestadas  pelo  CONTRATADO.  Em  casos  de \ndispensa ou benefício fiscal que implique em redução ou eliminação da retenção \nde tributos, o CONTRATADO fornecerá todos os documentos comprobatórios. \n\nParágrafo Sétimo \nCaso o CONTRATADO emita documento fiscal ou equivalente legal autorizado \npor Município diferente daquele onde se localiza o estabelecimento do BNDES \ntomador do serviço e destinatário da cobrança, deverá providenciar o cadastro \njunto à Secretaria Municipal de Fazenda ou órgão equivalente do Município do \nestabelecimento tomador, salvo quando se aplicar uma das exceções constantes \ndos incisos do artigo 3º da Lei Complementar Federal nº 116/03. A inexistência \ndesse  cadastro  ou  o  cadastro  em  item  diverso  do  faturado  não  constitui \nimpeditivo  ao  processo  de  pagamento,  mas  um  ônus  a  ser  suportado  pelo \nCONTRATADO, uma vez que o BNDES está obrigado a reter na fonte a quantia \nequivalente ao ISS dos serviços faturados, conforme legislação aplicável. \n\nParágrafo Oitavo \nO  documento  fiscal  ou  equivalente  legal  emitido  pelo  CONTRATADO  deverá \nestar em conformidade com a legislação do Município onde o CONTRATADO \nesteja estabelecido, cuja regularidade fiscal foi avaliada na etapa de habilitação, \ne com as normas regulamentares aprovadas pela Secretaria da Receita Federal \ndo  Brasil,  especialmente  no  que  tange  à  retenção  de  tributos,  sob  pena  de \ndevolução do documento e interrupção do prazo para pagamento.  \n\nParágrafo Nono \nAo documento fiscal ou equivalente legal deverão ser anexados: \n\nContrato OCS nº 295/2024 \nContratante: BNDES \nContratado: KRYPTUS SEGURANÇA DA INFORMAÇÃO S.A. \n\n5                                                                                                                             \n\n \n \n \n \nClassificação: Documento Ostensivo (Lei nº 13.303/2016) \nUnidade Gestora: AJI/JULIC/GLIC4 \n\nI. certidões de regularidade fiscal exigidas na fase de habilitação; \n\nII. comprovante de que o CONTRATADO é optante do Simples Nacional, se for \no caso; \n\nIII. em caso de isenção/imunidade tributária, documentos comprobatórios com a \nindicação do dispositivo legal que ampara a isenção/imunidade; e \n\nIV.  demais  documentos  solicitados  pelo  Gestor  do  Contrato,  necessários  ao \npagamento do objeto contratado. \n\nParágrafo Décimo \nCaso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou \nequivalente  legal  ao  CONTRATADO  ou  solicitará  a  emissão  de  carta  de \ncorreção, quando cabível, interrompendo-se o prazo de pagamento até que este \nprovidencie  as  medidas  saneadoras  ou  comprove  a  correção  dos  dados \ncontestados pelo BNDES.  \n\nParágrafo Décimo Primeiro \nAlém  de  outras  hipóteses  previstas  em  lei  ou  no  Contrato,  o  BNDES  poderá \ndescontar, do montante expresso no documento fiscal ou equivalente legal, os \nvalores referentes a multas, indenizações apuradas em processo administrativo, \nbem  como  qualquer  obrigação  que  decorra  do  descumprimento  da  legislação \npelo CONTRATADO. \n\nParágrafo Décimo Segundo \nCaso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em \ndecorrência de fato não atribuível ao CONTRATADO, aos valores devidos serão \nacrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, \ncalculados desde o dia do vencimento até a data da efetiva liquidação. \n\nParágrafo Décimo Terceiro \nFica  assegurado  ao  BNDES  o  direito  de  deduzir  do  pagamento  devido  ao \nCONTRATADO, por força deste Contrato ou de outro contrato mantido com o \nBNDES,  o  valor  correspondente  aos  pagamentos  efetuados  a  maior  ou  em \nduplicidade.', 'clausula_setima_pagamento').
contract_metadata_raw(contrato_ocs_295_2024, 'Contrato OCS nº', '295/2024', 'preambulo').
contract_metadata_raw(contrato_ocs_295_2024, 'Contratante', 'BNDES', 'preambulo').
contract_metadata_raw(contrato_ocs_295_2024, 'Contratado', 'KRYPTUS SEGURANÇA DA INFORMAÇÃO S.A.', 'preambulo').
contract_clause(contrato_ocs_295_2024, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA  OITAVA  –  EQUILÍBRIO  ECONÔMICO-FINANCEIRO  DO \nCONTRATO', 'O BNDES e o CONTRATADO têm direito ao equilíbrio econômico-financeiro do \nContrato,  em  consonância  com  o  inciso  XXI,  do  artigo  37,  da  Constituição \nFederal, a ser realizado mediante reajuste ou revisão de preços.').
contract_clause(contrato_ocs_295_2024, clausula_oitava_paragrafo_primeiro, 'Parágrafo Primeiro', 'O reajuste de preços, na forma prevista na legislação, poderá ser requerido pelo \nCONTRATADO a cada período de 12 (doze) meses, sendo o primeiro contado \ndo dia 06/06/2024, data de apresentação da proposta (Anexo II deste Contrato), \ne os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do \níndice  IPCA  acumulado  sobre  o  preço  referido  na  Cláusula  de  Preço  deste \nInstrumento.').
contract_clause(contrato_ocs_295_2024, clausula_oitava_paragrafo_segundo, 'Parágrafo Segundo', 'A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante \nsolicitação  do  CONTRATADO,  quando  ocorrer  fato  imprevisível  ou  previsível, \nporém, de consequências incalculáveis, retardador ou impeditivo da execução \ndo Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, \nconfigurando  álea  econômica  extraordinária  e  extracontratual,  que  onere  ou \ndesonere  as  obrigações  pactuadas  no  presente  Instrumento,  sendo,  porém, \nvedada  nas  hipóteses  em  que  o  risco  seja  alocado  ao  CONTRATADO  nos \ntermos da Cláusula de Matriz de Riscos, respeitando-se o seguinte:\n\nI. o CONTRATADO deverá formular ao BNDES requerimento para a revisão do \nContrato, comprovando a ocorrência do fato gerador;\n\nII.  a  comprovação  será  realizada  por  meio  de  documentos,  tais  como,  atos \nnormativos  que  criem  ou  alterem  tributos,  lista  de  preço  de  fabricantes,  notas \nfiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas \nà  época  da  elaboração  da  proposta  ou  do  último  reajuste  e  do  momento  do \npedido de revisão; e\n\nIII. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos \nunitários,  comparativas  entre  a  data  da  formulação  da  proposta  ou  do  último \nreajuste e o momento do pedido de revisão, contemplando os custos unitários \nenvolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no \nvalor pactuado.').
contract_clause(contrato_ocs_295_2024, clausula_oitava_paragrafo_terceiro, 'Parágrafo Terceiro', 'Independentemente  de  solicitação,  o  BNDES  poderá  convocar  o \nCONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto \ncontratado,  na  quantidade  e  nas  especificações  indicadas  na  proposta,  em \nvirtude da redução dos preços de mercado, ou de itens que compõem o custo, \ncabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.').
contract_clause(contrato_ocs_295_2024, clausula_oitava_paragrafo_quarto, 'Parágrafo Quarto', 'O  CONTRATADO  deverá  solicitar  o  reajuste  e/ou  a  revisão  de  preços  até  o \nencerramento  do  Contrato,  hipótese  em  que  os  efeitos  financeiros  serão \nconcedidos de modo retroativo a partir do fato gerador, observando-se, ainda, \nque:\n\nI. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do \níndice  de  reajuste  ocorra  com  antecedência  inferior  a  60  (sessenta)  dias  do \nencerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, \na  contar  do  fato  gerador  ou  da  data  de  divulgação  do  índice,  para  solicitar  o \nreajuste e/ou a revisão de preços;\n\nII.  caso  a  divulgação  do  índice  de  reajuste  ocorra  após  o  encerramento  do \nContrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato \ngerador ou da data de divulgação do índice, para solicitar o reajuste de preços;\n\nIII. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até \n60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO \ndos  comprovantes  de  variação  dos  custos,  ficando  este  prazo  suspenso,  a \ncritério do BNDES, enquanto o CONTRATADO não apresentar a documentação \nsolicitada para a comprovação da variação de custos; e\n\nIV.  caso  o  CONTRATADO  não  solicite  o  reajuste  e/ou  revisão  de  preços  nos \nprazos  fixados acima,  não  fará  jus  aos  efeitos  retroativos  ou,  caso  o  Contrato \nesteja  encerrado,  operar-se-á  a  renúncia  a  eventual  direito  ao  reajuste  e/ou  à \nrevisão.').
contract_clause(contrato_ocs_295_2024, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS', 'O  BNDES  e  o  CONTRATADO,  tendo  como  premissa  a  obtenção  do  melhor \ncusto  contratual  mediante  a  alocação  do  risco  à  parte  com  maior  capacidade \npara geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual \ne,  sem  prejuízo  de  outras  previsões  contratuais,  estabelecem  os  respectivos \nresponsáveis na Matriz de Riscos constante do Anexo III deste Contrato.').
contract_clause(contrato_ocs_295_2024, clausula_nona_paragrafo_primeiro, 'Parágrafo Primeiro', 'O  reajuste  de  preço aludido  na  Matriz  de  Riscos  deve  respeitar o disposto  na\n\nCláusula de Equilíbrio Econômico-Financeiro deste Contrato.').
contract_clause(contrato_ocs_295_2024, clausula_nona_paragrafo_segundo, 'Parágrafo Segundo', 'É  vedada  a  celebração  de  aditivos  decorrentes  de  eventos  supervenientes \nalocados, na Matriz de Riscos, como de responsabilidade do CONTRATADO.').
contract_clause(contrato_ocs_295_2024, clausula_decima_garantia_contratual, 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL', 'O CONTRATADO prestará, no prazo de até 15 (quinze) dias úteis, contados da \nconvocação,  garantia  contratual,  sob  pena  de  aplicação  de  penalidade  nos \ntermos deste Contrato, observadas as condições para sua aceitação estipuladas \nnos incisos abaixo, no valor de R$ 62.800,00 (sessenta e dois mil e oitocentos \nreais) que lhe será devolvida após a verificação do cumprimento fiel, correto e \nintegral dos termos contratuais.').
contract_clause(contrato_ocs_295_2024, clausula_decima_i_caucao_dinheiro, 'I. Caução em dinheiro', 'deverá ser depositada em favor do BNDES, de acordo \ncom as orientações que serão fornecidas quando da referida convocação;').
contract_clause(contrato_ocs_295_2024, clausula_decima_ii_seguro_garantia, 'II.  Seguro  Garantia', 'a  Apólice  de  Seguro  deverá  ser  emitida  por  Instituição \nautorizada pela SUSEP a operar no mercado securitário, que não se encontre \nsob  regime  de  Direção  Fiscal,  Intervenção,  Liquidação  Extrajudicial  ou \nFiscalização  Especial,  e  que  não  esteja  cumprindo  penalidade  de  suspensão \nimposta pela SUSEP;').
contract_clause(contrato_ocs_295_2024, clausula_decima_ii_a_o_instrumento_de_apolice_de_seguro_deve_prever_expressamente, 'a) O Instrumento de Apólice de Seguro deve prever expressamente', 'a.1)  responsabilidade  da  seguradora  por  todas  e  quaisquer  multas  de  caráter \nsancionatório aplicadas ao CONTRATADO;\n\na.2) vigência pelo prazo contratual;\n\na.3)  prazo  de  90  (noventa)  dias,  contados  a  partir  do  término  da  vigência \ncontratual,  para  apuração  de  eventual  inadimplemento  do  CONTRATADO  - \nocorrido durante a vigência contratual -, e para a comunicação da expectativa de \nsinistro  ou  do  efetivo  aviso  de  sinistro,  observados  os  prazos  prescricionais \npertinentes.').
contract_clause(contrato_ocs_295_2024, clausula_decima_iii_fianca_bancaria, 'III.  Fiança  Bancária', 'a  Carta  de  Fiança  deverá  ser  emitida  por  Instituição \nFinanceira autorizada pelo Banco Central do Brasil - BACEN para funcionar no \nBrasil  e  que  não  se  encontre  em  processo  de  liquidação  extrajudicial  ou  de \nintervenção do BACEN.').
contract_clause(contrato_ocs_295_2024, clausula_decima_iii_a_o_instrumento_de_fianca_deve_prever_expressamente, 'a) O Instrumento de Fiança deve prever expressamente', 'a.1) renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 \ndo Código Civil;\n\na.2) vigência pelo prazo contratual;\n\na.3)  prazo  de  90  (noventa)  dias,  contados  a  partir  do  término  da  vigência \ncontratual,  para  apuração  de  eventual  inadimplemento  do  CONTRATADO  - \nocorrido  durante  a  vigência  contratual  -,  e  para  a  comunicação  do \ninadimplemento  à  Instituição  Financeira,  observados  os  prazos  prescricionais \npertinentes.').
contract_clause(contrato_ocs_295_2024, clausula_decima_paragrafo_primeiro, 'Parágrafo Primeiro', 'O  prazo  previsto  para  a  apresentação  da  garantia  poderá  ser  prorrogado,  por \nigual  período,  quando  solicitado  pelo  CONTRATADO  durante  o  respectivo \ntranscurso, e desde que ocorra motivo justificado e aceito pelo BNDES.').
contract_clause(contrato_ocs_295_2024, clausula_decima_paragrafo_segundo, 'Parágrafo Segundo', 'Havendo majoração do preço contratado, decorrente de reajuste, repactuação \nou  revisão  de  preços  causada  por  alterações  na  legislação  tributária,  fica \ndispensada a atualização da garantia, salvo se o valor da atualização for igual \nou superior ao patamar referenciado no inciso II do artigo 91 do Regulamento de \nLicitações e Contratos do SISTEMA BNDES.').
contract_clause(contrato_ocs_295_2024, clausula_decima_paragrafo_terceiro, 'Parágrafo Terceiro', 'Nos demais casos que demandem a complementação ou renovação da garantia, \ntais  como  alteração  do  objeto  (aditivo  quantitativo  ou  qualitativo),  prorrogação \ncontratual,  dentre  outros,  o  CONTRATADO  deverá  providenciá-la  no  prazo \nestipulado pelo BNDES.').
contract_clause(contrato_ocs_295_2024, clausula_decima_paragrafo_quarto, 'Parágrafo Quarto', 'Sempre que o contrato for garantido por fiança bancária ou seguro garantia, o \nCONTRATADO deve obter do garantidor anuência em relação à manutenção da \ngarantia,  no  prazo  de 10  (dez)  dias  úteis  a contar da  assinatura  do  aditivo ou \nrecebimento  de  carta  de  apostilamento  ou  aditivo  epistolar,  conforme  o  caso. \nRecusando-se o garantidor a manter a garantia, cabe ao CONTRATADO obter \nnova  garantia  no  mesmo  prazo,  prorrogável  por  igual  período  a  critério  do \nBNDES.').
contract_clause(contrato_ocs_295_2024, clausula_decima_paragrafo_quinto, 'Parágrafo Quinto', 'A garantia contratual deverá cobrir:\n\nI. todas as obrigações decorrentes do objeto contratual, assim como eventuais \ndanos decorrentes de seu descumprimento;\n\nII. todas as obrigações relacionadas ao objeto principal, ainda que decorrentes \nde  sua  manutenção  e/ou  refazimento,  bem  como  das  medidas  necessárias  à \nprevenção ordinária de sinistros, prejuízos e danos em geral;\n\nIII.  prejuízos  decorrentes  de  atos  de  corrupção  praticados  sem  participação \ndolosa do BNDES ou de seus representantes;\n\nIV. prejuízos diretos causados ao BNDES decorrentes de culpa ou dolo durante \na execução do Contrato;\n\nV. multas moratórias e/ou punitivas aplicadas pelo BNDES ao CONTRATADO;  \n\nVI.  obrigações  trabalhistas  e  previdenciárias  de  qualquer  natureza,  não \nadimplidas pelo CONTRATADO, quando o objeto contratual demandar cessão \nde mão de obra com dedicação exclusiva.').
contract_clause(contrato_ocs_295_2024, clausula_decima_paragrafo_sexto, 'Parágrafo Sexto', 'Em  caso  de  prorrogação  da  vigência  ou  alteração  do  objeto  contratual,  o \nCONTRATADO  deverá  notificar  a  entidade  fiadora/seguradora,  conforme  o \ncaso, no prazo de até 10 (dez) dias úteis, contados da formalização do respectivo \nInstrumento Contratual.').
contract_clause(contrato_ocs_295_2024, clausula_decima_paragrafo_setimo, 'Parágrafo Sétimo', 'Por se tratar de garantia contratual prestada em benefício de uma Estatal, caso \nos  documentos  de  caução,  fiança  ou  seguro  façam  referência  à  Lei  nº \n8.666/1993 e/ou à Lei nº 14.133/2021, aplicam-se as disposições respectivas da \nLei nº 13.303/2016, no que couber.').
contract_clause(contrato_ocs_295_2024, clausula_decima_primeira_obrigacoes_contratado, 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DO CONTRATADO \nAlém de outras obrigações estabelecidas neste Instrumento, em seus anexos ou \nnas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em \nvigor, constituem obrigações do CONTRATADO: \n\nI. manter durante a vigência deste Contrato todas as condições de habilitação e \na ausência de impedimentos exigidas quando da contratação, comprovando-as \nsempre que solicitado pelo BNDES; \n\nII.  comunicar  a  imposição,  de  penalidade  que  acarrete  o  impedimento  de \ncontratar com o BNDES, bem como a eventual perda dos pressupostos para a \nlicitação; \n\nIII. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total \nou  em  parte,  o  objeto  do  Contrato  em  que  se  verificarem  vícios,  defeitos  ou \nicorreções decorrentes da execução; \n\nIV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não \nrestando  excluída  ou  reduzida  esta  responsabilidade  pela  presença  de \nfiscalização  ou  pelo  acompanhamento  da  execução  por  parte  do  Gestor  do \nContrato; \n\nV. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta \nou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer \nmomento, exigir do CONTRATADO a comprovação de sua regularidade; \n\nVI.  assumir  a  responsabilidade  integral por quaisquer  ônus  que  venham  a  ser \nimpostos  ao  BNDES  em  virtude  de  documento  fiscal  que  seja  emitido  em \ndesacordo com a legislação aplicável; \n\nVII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao \nBNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo \nartigo  30  da  Lei  Complementar  nº  123/2006,  se  o  CONTRATADO,  quando \noptante: \n\na)  extrapolar  o  limite  de  receita  bruta  anual  previsto  no  artigo  3º  da  Lei \nComplementar nº 123/2006, ao longo da vigência deste Contrato; ou \n\nb)  enquadrar-se  em  alguma  das  situações  previstas  no  artigo  17  da  Lei \nComplementar nº 123/2006; \n\nVIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do \nContrato; \n\nIX.  obedecer  às  instruções  e  aos  procedimentos,  estabelecidos  pelo  BNDES, \npara a adequada execução do Contrato; \n\nX.  designar  01  (um)  preposto  como  responsável  pelo  Contrato  firmado  com  o \nBNDES,  para  participar  de  eventuais  reuniões  e  ser  o  interlocutor  do \n\n\n\nCONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste \nInstrumento; \n\nXI. Fornecer informações para o gerenciamento, por parte do BNDES, de riscos \nsocial, ambiental ou climático, relacionados ao objeto do contrato. \n\nXI. apresentar, em até 10 (dez) dias úteis após a convocação, a Declaração de \nInformações para Fornecimento - DIF, adequadamente preenchida, sob pena de \ninstauração  de  procedimento  punitivo  para  aplicação  de  penalidade,  e  de \nretenção  tributária,  pelo  BNDES,  nos  casos  previstos  em  lei,  da  alíquota  que \nentender adequada; \n\n\n\na)  as \ninformações  inseridas  na  Declaração  de \nInformações  para \nFornecimento  –  DIF  não  deverão  divergir  das  constantes  do  documento \nfiscal ou equivalente legal.', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou \nnas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em \nvigor, constituem obrigações do CONTRATADO: \n\nI. manter durante a vigência deste Contrato todas as condições de habilitação e \na ausência de impedimentos exigidas quando da contratação, comprovando-as \nsempre que solicitado pelo BNDES; \n\nII.  comunicar  a  imposição,  de  penalidade  que  acarrete  o  impedimento  de \ncontratar com o BNDES, bem como a eventual perda dos pressupostos para a \nlicitação; \n\nIII. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total \nou  em  parte,  o  objeto  do  Contrato  em  que  se  verificarem  vícios,  defeitos  ou \nicorreções decorrentes da execução; \n\nIV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não \nrestando  excluída  ou  reduzida  esta  responsabilidade  pela  presença  de \nfiscalização  ou  pelo  acompanhamento  da  execução  por  parte  do  Gestor  do \nContrato; \n\nV. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta \nou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer \nmomento, exigir do CONTRATADO a comprovação de sua regularidade; \n\nVI.  assumir  a  responsabilidade  integral por quaisquer  ônus  que  venham  a  ser \nimpostos  ao  BNDES  em  virtude  de  documento  fiscal  que  seja  emitido  em \ndesacordo com a legislação aplicável; \n\nVII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao \nBNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo \nartigo  30  da  Lei  Complementar  nº  123/2006,  se  o  CONTRATADO,  quando \noptante: \n\na)  extrapolar  o  limite  de  receita  bruta  anual  previsto  no  artigo  3º  da  Lei \nComplementar nº 123/2006, ao longo da vigência deste Contrato; ou \n\nb)  enquadrar-se  em  alguma  das  situações  previstas  no  artigo  17  da  Lei \nComplementar nº 123/2006; \n\nVIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do \nContrato; \n\nIX.  obedecer  às  instruções  e  aos  procedimentos,  estabelecidos  pelo  BNDES, \npara a adequada execução do Contrato; \n\nX.  designar  01  (um)  preposto  como  responsável  pelo  Contrato  firmado  com  o \nBNDES,  para  participar  de  eventuais  reuniões  e  ser  o  interlocutor  do \n\n\n\nCONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste \nInstrumento; \n\nXI. Fornecer informações para o gerenciamento, por parte do BNDES, de riscos \nsocial, ambiental ou climático, relacionados ao objeto do contrato. \n\nXI. apresentar, em até 10 (dez) dias úteis após a convocação, a Declaração de \nInformações para Fornecimento - DIF, adequadamente preenchida, sob pena de \ninstauração  de  procedimento  punitivo  para  aplicação  de  penalidade,  e  de \nretenção  tributária,  pelo  BNDES,  nos  casos  previstos  em  lei,  da  alíquota  que \nentender adequada; \n\n\n\na)  as \ninformações  inseridas  na  Declaração  de \nInformações  para \nFornecimento  –  DIF  não  deverão  divergir  das  constantes  do  documento \nfiscal ou equivalente legal.').
contract_clause(contrato_ocs_295_2024, clausula_decima_segunda_conduta_etica_contratado_bndes, 'CLÁUSULA  DÉCIMA  SEGUNDA  –  CONDUTA  ÉTICA  DO  CONTRATADO  E \nDO BNDES \nO  CONTRATADO  e  o  BNDES  comprometem-se  a  manter  a  integridade  nas \nrelações público-privadas, agindo de boa-fé e de acordo com os princípios da \nmoralidade administrativa e da impessoalidade, além de pautar sua conduta por \npreceitos éticos e, em especial, por sua responsabilidade socioambiental. \n\nParágrafo Primeiro \nEm atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-\nse, inclusive, a: \n\nI.  não  oferecer,  prometer,  dar,  autorizar,  solicitar  ou  aceitar,  direta  ou \nindiretamente,  qualquer  vantagem  indevida,  seja  pecuniária  ou  de  outra \nnatureza, consistente em fraude, ato de corrupção ou qualquer outra violação de \ndever legal, relacionada com este Contrato, bem como a tomar todas as medidas \nao  seu  alcance  para
contract_clause(contrato_ocs_295_2024, clausula_decima_terceira_sigilo_informacoes, 'CLÁUSULA DÉCIMA TERCEIRA – SIGILO DAS INFORMAÇÕES \nCabe  ao  CONTRATADO  cumprir  as  seguintes  regras  de  sigilo  e  assegurar  a \naceitação  e  adesão  às  mesmas  por  profissionais  que  integrem  ou  venham  a \nintegrar  a  sua  equipe  na  prestação  do  objeto  deste  Contrato,  as  quais \nperdurarão, inclusive, após a cessação do vínculo contratual e da prestação dos \nserviços: \n\nI.  cumprir  as  diretrizes  e  normas  da  Política  Corporativa  de  Segurança  da \nInformação do BNDES, necessárias para assegurar a integridade e o sigilo das \ninformações;  \n\nII.  não  acessar  informações  sigilosas  do  BNDES,  salvo  quando  previamente \nautorizado por escrito; \n\nIII. sempre que tiver acesso às informações mencionadas no inciso anterior: \n\na) manter sigilo dessas informações, não podendo copiá-las, reproduzi-las, \nretê-las  ou  praticar  qualquer  outra
contract_metadata_raw(contrato_ocs_295_2024, 'Contrato OCS nº', '295/2024', 'texto_preambulo').
contract_metadata_raw(contrato_ocs_295_2024, 'Contratante', 'BNDES', 'texto_preambulo').
contract_metadata_raw(contrato_ocs_295_2024, 'Contratado', 'KRYPTUS SEGURANÇA DA INFORMAÇÃO S.A.', 'texto_preambulo').
contract_clause(contrato_ocs_295_2024, clausula_decima_quarta_acesso_protecao_dados_pessoais, 'CLÁUSULA  DÉCIMA  QUARTA  –  ACESSO  E  PROTEÇÃO  DE  DADOS \nPESSOAIS', 'As  partes  assumem  o  compromisso  de  proteger  os  direitos  fundamentais  de \nliberdade e de privacidade, relativos ao tratamento de dados pessoais, nos meios \nfísicos e digitais, devendo, para tanto, adotar medidas de boa governança sob o \naspecto  técnico,  jurídico  e  administrativo,  inclusive  de  segurança,  e  observar \nque:   \n\nI.Eventual tratamento de dados pessoais em razão do presente Contrato deverá \nser realizado conforme os parâmetros previstos na legislação, especialmente na \nLei n° 13.709/2018 – Lei Geral de Proteção de Dados Pessoais - LGPD, dentro \nde propósitos legítimos, específicos, explícitos e informados ao titular;  \n\nII.O  tratamento  será  limitado  às  atividades  necessárias  ao  atingimento  das \nfinalidades  contratuais  e,  caso  seja  necessário,  ao  cumprimento  de  suas \nobrigações  legais  ou  regulatórias,  sejam  de  ordem  principal  ou  acessória, \nobservando-se  que,  em  caso  de  necessidade  de  coleta  de  dados  pessoais \ndiretamente  pelo  CONTRATADO,  esta  será  realizada  mediante  prévia \naprovação  do  BNDES,  responsabilizando-se  o  CONTRATADO  por  obter  o \nconsentimento dos titulares, salvo nos casos em que a legislação dispense tal \nmedida; \n\nIII.O CONTRATADO deverá seguir as instruções recebidas do BNDES em relação \n\nao tratamento de dados pessoais; \n\nIV.No caso de tratamento de dados pessoais realizado pelo CONTRATADO para \ncumprimento de suas obrigações legais ou para atendimento de suas próprias \nfinalidades, o BNDES não será considerado “Controlador de Dados Pessoais” e, \nsim, o CONTRATADO; \n\nV.Os  dados  coletados  somente  poderão  ser  utilizados  pelas  partes,  seus \nrepresentantes, empregados e prestadores de serviços diretamente alocados na \nexecução  contratual,  sendo  que,  em  hipótese  alguma,  poderão  ser \ncompartilhados  ou  utilizados  para  outros  fins,  sem  a  prévia  autorização  do \nBNDES,  ou  caso  haja  alguma  ordem  judicial,  observando-se  as  medidas \nlegalmente previstas para tanto; \n\nVI.O CONTRATADO deve manter a confidencialidade dos dados pessoais obtidos \nem  razão  do  presente  contrato,  devendo  adotar  as  medidas  técnicas  e \nadministrativas  adequadas  e  necessárias,  visando  assegurar  a  proteção  dos \ndados, nos termos do artigo 46 da LGPD, de modo a garantir um nível apropriado \nde segurança e a prevenção e mitigação de eventuais riscos; \n\nContrato OCS nº 295/2024 \nContratante: BNDES \nContratado: KRYPTUS SEGURANÇA DA INFORMAÇÃO S.A.\n\n15                                                                                                                             \n\n \n \n \n \n \n \n \n\n\n\nClassificação: Documento Ostensivo (Lei nº 13.303/2016) \nUnidade Gestora: AJI/JULIC/GLIC4 \n\nVII.Os dados deverão ser armazenados de maneira segura pelo CONTRATADO, \nque  utilizará  recursos  de  segurança  da  informação  e  tecnologia  adequados, \ninclusive  quanto  a  mecanismos  de  detecção  e  prevenção  de  ataques \ncibernéticos e incidentes de segurança da informação.  \n\nVIII.O  CONTRATADO  dará  conhecimento  formal  para  seus  empregados  e/ou \nprestadores  de  serviço  acerca  das  disposições  previstas  nesta  Cláusula  e  na \nCláusula  de  Sigilo  das  Informações,  responsabilizando-se  por  eventual  uso \nindevido dos dados pessoais, bem como por quaisquer falhas nos sistemas por \nela empregados para o tratamento dos dados. \n\nIX.O BNDES possui direito de regresso em face do CONTRATADO em razão de \neventuais  danos  causados  por  este  em  decorrência  do  descumprimento  das \nresponsabilidades e obrigações previstas no âmbito deste contrato e da Lei Geral \nde Proteção de Dados Pessoais; \n\nX.O CONTRATADO deverá disponibilizar ao titular do dado um canal ou sistema \nem que seja garantida consulta facilitada e gratuita sobre a forma, a duração do \ntratamento e a integralidade de seus dados pessoais. \n\nXI.O  CONTRATADO  deverá  informar  imediatamente  ao  BNDES  todas  as \nsolicitações recebidas em razão do exercício dos direitos pelo titular dos dados \nrelacionados  a este  Contrato,  seguindo  as  orientações  fixadas  pelo  BNDES  e \npela legislação em vigor para o adequado endereçamento das demandas. \n\nXII.O CONTRATADO deverá manter registro de todas as operações de tratamento \nde dados pessoais que realizar no âmbito do Contrato disponibilizando, sempre \nque solicitado pelo BNDES, as informações necessárias à produção do Relatório \nde  Impacto  de  Dados  Pessoais,  disposto  no  artigo  5º,  XVII,  da  Lei  Geral  de \nProteção de Dados Pessoais. \n\nXIII.Qualquer incidente ao qual o CONTRATADO tiver dado causa e que implique \nem violação ou risco de violação ou vazamento de dados pessoais deverá ser \nprontamente  comunicado  ao  BNDES,
contract_clause(contrato_ocs_295_2024, clausula_decima_quinta_obrigacoes_bndes, 'CLÁUSULA DÉCIMA QUINTA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou \nnas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em \nvigor, constituem obrigações do BNDES: \n\nI.  realizar  os  pagamentos  devidos  ao  CONTRATADO,  nas  condições \nestabelecidas neste Contrato; \n\nII. designar, como Gestor do Contrato, Mário Roberto Ginglass, que atualmente \nexerce  a  função  de  Gerente  da  AIC/DEROP/GSEG,  a  quem  caberá  o \nacompanhamento, a fiscalização e a avaliação da execução dos serviços, bem \ncomo  a  liquidação  da  despesa  e  o  atestado  de  cumprimento  das  obrigações \nassumidas; \n\nIII. designar, como substituto do Gestor do Contrato, para atuar em sua eventual \nausência, Giuliano Freitas de Paula Petrilo, que atualmente exerce a função de \nCoordenador de Serviços da AIC/DEROP/GSEG. \n\nIV. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por \noutro profissional, mediante comunicação escrita ao CONTRATADO; \n\nV. fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, acesso \nao Código de Ética do Sistema BNDES, da Política Corporativa de Integridade \ndo Sistema BNDES e da Política Corporativa de Segurança da Informação do \nBNDES; \n\nVI. colocar à disposição do CONTRATADO todas as informações necessárias à \nperfeita execução dos serviços objeto deste Contrato; e \n\nVII. comunicar ao CONTRATADO, por escrito:  \n\na)  quaisquer  instruções  ou  procedimentos  sobre  assuntos  relacionados  ao \nContrato; \n\nb)  a  abertura  de  procedimento  administrativo  para  a  apuração  de  condutas \nirregulares do CONTRATADO, concedendo-lhe prazo para defesa; e \n\nc) a aplicação de eventual penalidade, nos termos deste Contrato.'),
contract_clause(contrato_ocs_295_2024, clausula_decima_sexta_equidade_genero_valorizacao_diversidade, 'CLÁUSULA  DÉCIMA  SEXTA  –  EQUIDADE  DE  GÊNERO  E  VALORIZAÇÃO \nDA DIVERSIDADE', 'O  CONTRATADO  deverá  comprovar,  sempre  que  solicitado  pelo  BNDES,  a \nfinal  sancionadora,  exarada  por \ninexistência  de  deisão  administrativa \nautoridade  ou  órgão  competente,  em  razão  da  prática  de  atos,  pelo  próprio \nCONTRATADO  ou  dirigentes,  administradores  ou  sócios  majoritários,  que \nimportem  em  discriminação  de  raça  ou  gênero,  exploração  irregular,  ilegal  ou \ncriminosa do trabalho infantil ou prática relacionada ao trabalho em condições \nanálogas  à  escravidão,  e  de  sentença  condenatória  transitada  em  julgado, \nproferida  em  decorrência  dos  referidos  atos,  e,  se  for  o  caso,  de  outros  que \ncaracterizem  assédio  moral  ou  sexual  e  importem  em  crime  contra  o  meio \nambiente.\n\nParágrafo Primeiro \nNa  hipótese  de  ter  havido  decisão  administrativa  e/ou  sentença  condenatória, \nnos termos referidos no caput desta Cláusula, a execução do objeto contratual \npoderá  ser  suspensa  pelo  BNDES  até  a  comprovação  do  cumprimento  da \nreparação imposta ou da reabilitação do CONTRATADO ou de seus dirigentes, \nconforme o caso.\n\nParágrafo Segundo \nA comprovação a que se refere o caput desta Cláusula será realizada por meio \nde  declaração,  sem  prejuízo  da  verificação  do  sistema  informativo  interno  do \nBNDES – Sistema de Gerenciamento do Cadastro de Entidades (N02), acerca \nda inexistência de sanção em face do CONTRATADO e/ou de seus dirigentes, \nadministradores ou sócios majoritários que impeça a contratação.').
contract_clause(contrato_ocs_295_2024, clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, 'CLÁUSULA DÉCIMA SÉTIMA – CESSÃO DE CONTRATO OU DE CRÉDITO, \nSUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO', 'É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito \ndele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer \ntítulo de crédito em razão do mesmo.\n\nParágrafo Primeiro \nÉ  admitida  a  sucessão  contratual  nas  hipóteses  em  que  o  CONTRATADO \nrealizar as operações societárias de fusão, cisão ou incorporação, condicionada \naos seguintes requisitos: \n\nI. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos \ndecorrentes de tal alteração contratual; e \nII.  manutenção  de  todas  as  condições  contratuais  e  requisitos  de  habilitação \noriginais.\n\nContrato OCS nº 295/2024 \nContratante: BNDES \nContratado: KRYPTUS SEGURANÇA DA INFORMAÇÃO S.A.\n\n19                                                                                                                             \n\n \n \n \n \n \n \n \nClassificação: Documento Ostensivo (Lei nº 13.303/2016) \nUnidade Gestora: AJI/JULIC/GLIC4').
contract_clause(contrato_ocs_295_2024, clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_segundo, 'Parágrafo Segundo', 'Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor \nassumirá integralmente a posição do sucedido, passando a ser responsável pela \nexecução do presente Contrato, fazendo, por conseguinte, jus ao recebimento \ndos créditos dele decorrentes.').
contract_clause(contrato_ocs_295_2024, clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_terceiro, 'Parágrafo Terceiro', 'É vedada a subcontratação para a execução do objeto deste Contrato.').
contract_clause(contrato_ocs_295_2024, clausula_decima_oitava_penalidades, 'CLÁUSULA DÉCIMA OITAVA – PENALIDADES', 'Em  caso  de \ninexecução\ninclusive  de \ndescumprimento  de  exigência  expressamente  formulada  pelo  BNDES  ou  de \ninobservância de qualquer obrigação legal, bem como em caso de mora, sem \nmotivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: \n\ntotal  ou  parcial  do  Contrato, \n\nI. advertência; \n\nII. multa, de acordo com o Anexo I (Termo de Referência); e \n\nIII.  suspensão  temporária  de  participação  em  licitação  e  impedimento  de \ncontratar  com  o  BNDES,  por  prazo  não  superior  a  2  (dois)  anos,  apurado  de \nacordo com a gravidade da infração.\n\nParágrafo Primeiro \nAs  penalidades  serão  aplicadas  observadas  as  normas  do  Regulamento  de \nLicitações e Contratos do SISTEMA BNDES.  \n\nParágrafo Segundo  \nContra a decisão de aplicação de penalidade, o CONTRATADO poderá requerer \na reconsideração para a decisão de advertência, ou interpor o recurso cabível \npara as demais penalidades, na forma e no prazo previstos no Regulamento de \nLicitações e Contratos do SISTEMA BNDES.\n\nParágrafo Terceiro  \nA imposição de penalidade prevista nesta Cláusula não impede a extinção do \nContrato  pelo  BNDES,  nos  termos  da  legislação  aplicável  e  da  Cláusula  de \nExtinção do Contrato.  \n\nParágrafo Quarto  \nA multa poderá ser aplicada juntamente com as demais penalidades.\n\nParágrafo Quinto  \nA multa aplicada ao CONTRATADO e os prejuízos causados ao BNDES serão \ndeduzidos de quaisquer créditos a ele devidos, assim como da garantia prestada, \n\nContrato OCS nº 295/2024 \nContratante: BNDES \nContratado: KRYPTUS SEGURANÇA DA INFORMAÇÃO S.A.\n\n20                                                                                                                             \n\n \n \n \n \n \n \n \nClassificação: Documento Ostensivo (Lei nº 13.303/2016) \nUnidade Gestora: AJI/JULIC/GLIC4').
contract_clause(contrato_ocs_295_2024, clausula_decima_oitava_penalidades_paragrafo_quinto, 'Parágrafo Quinto', 'ressalvada a possibilidade de cobrança judicial da diferença eventualmente não \ncoberta pelos mencionados créditos.').
contract_clause(contrato_ocs_295_2024, clausula_decima_oitava_penalidades_paragrafo_sexto, 'Parágrafo Sexto', 'No  caso  de  atos  lesivos  à  Administração  Pública,  nacional  ou  estrangeira, \nobservar-se-ão os termos da Lei nº 12.846/2013.').
contract_clause(contrato_ocs_295_2024, clausula_decima_oitava_penalidades_paragrafo_setimo, 'Parágrafo Sétimo', 'A celebração de Termo de Ajustamento de Conduta prevista no Regulamento de \nLicitações  e  Contratos  do  Sistema  BNDES  não  importa  em  renúncia  às \npenalidades prevista neste Contrato e no Anexo I (Termo de Referência).').
contract_clause(contrato_ocs_295_2024, clausula_decima_oitava_penalidades_paragrafo_oitavo, 'Parágrafo Oitavo', 'A sanção prevista no inciso III desta Cláusula também poderá ser aplicada às \nsociedades ou profissionais que: \n\nI.  tenham  sofrido  condenação  definitiva  por  praticarem,  por  meios  dolosos, \nfraude fiscal no recolhimento de quaisquer tributos; \n\nII. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; \n\nIII. demonstrem não possuir idoneidade para contratar com o BNDES em virtude \nde atos ilícitos praticados.').
contract_clause(contrato_ocs_295_2024, clausula_decima_nona_alteracoes_contratuais, 'CLÁUSULA DÉCIMA NONA – ALTERAÇÕES CONTRATUAIS', 'O  presente  Contrato  poderá  ser  alterado,  por  acordo  entre  as  partes,  nas \nhipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou \ncontratualmente previstas, observando-se que:  \n\nI. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; \ne \n\nII. é vedada a modificação contratual que desnature o objeto da contratação ou \nafete as condições essenciais previstas no Termo de Referência (Anexo I deste \nContrato).\n\nParágrafo Primeiro \nEm atenção aos princípios que regem as relações contratuais, nas hipóteses em \nque  for  imprescindível  a  alteração  deste  Contrato  para  viabilizar  sua  plena \nexecução,  conforme  demonstrado  em  processo  administrativo,  não  caberá  a \nrecusa  das  partes  à  respectiva  formalização,  salvo  em  caso  de  justo  motivo, \ndevidamente comprovado pela parte que o alegar.').
contract_clause(contrato_ocs_295_2024, clausula_decima_nona_alteracoes_contratuais_paragrafo_segundo, 'Parágrafo Segundo', 'A  parte  que,  injustificadamente,  se  recusar  a  promover  a  alteração  contratual \nindicada  no  Parágrafo  anterior,  deverá  responder  pelos  danos  eventualmente \n\nContrato OCS nº 295/2024 \nContratante: BNDES \nContratado: KRYPTUS SEGURANÇA DA INFORMAÇÃO S.A.\n\n21                                                                                                                             \n\n \n \n \n \n \n \nClassificação: Documento Ostensivo (Lei nº 13.303/2016) \nUnidade Gestora: AJI/JULIC/GLIC4').
contract_clause(contrato_ocs_295_2024, clausula_decima_nona_alteracoes_contratuais_paragrafo_terceiro, 'Parágrafo Terceiro', 'As  alterações  contratuais  serão  formalizadas  mediante  instrumento  aditivo, \nressalvadas  as  hipóteses  legais  que  admitem  a  alteração  por  apostilamentos \najustes  necessários  à  eventual  correção  de  erros  materiais  ou  à  alteração  de \ndados acessórios do Contrato e alterações de preços decorrentes decorrente de \nreajuste, repactuação ou revisão de preços causada por alterações na legislação \ntributária, que poderão ser celebrados por meio epistolar.').
contract_clause(contrato_ocs_295_2024, clausula_vigesima_extincao_contrato, 'CLÁUSULA VIGÉSIMA – EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na \nlegislação, e ainda: \n\nI.  consensualmente,  formalizada  em  autorização  escrita  e  fundamentada  do \nBNDES,  mediante  aviso  prévio  por  escrito,  com  antecedência  mínima  de  90 \n(noventa)  dias  ou  de  prazo  menor  a  ser  negociado  pelas  partes  à  época  da \nrescisão; \n\nII. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, \ncabendo  à  parte  inocente  notificar  a  outra  por  escrito,  assinalando-lhe  prazo \nrazoável  para  o  cumprimento  das  obrigações,  quando  o  mesmo  não  for \npreviamente fixado neste instrumento ou em seus anexos; \n\nIII.  na  ausência  de  liberação,  por  parte  do  BNDES,  de  área,  local  ou  objeto \nnecessário para a sua execução, nos prazos contratuais; \n\nIV.  em  virtude  da  suspensão  da  execução  do  Contrato,  por  ordem  escrita  do \nBNDES,  por  prazo  superior  a  120  (cento  e  vinte)  dias  ou  ainda  por  repetidas \nsuspensões que totalizem o mesmo prazo;  \n\nV. quando for decretada a falência do CONTRATADO; \n\nVI.  caso  o  CONTRATADO  perca  uma  das  condições  de  habilitação  exigidas \nquando da contratação; \n\nVII.  na  hipótese  de  descumprimento  do  previsto  na  Cláusula  de  Cessão  de \nContrato ou de Crédito, Sucessão Contratual e Subcontratação; \n\nVIII. caso o CONTRATADO seja declarada inidôneo pela União, por Estado ou \npelo Distrito Federal;  \n\nIX. em função da suspensão do direito de o CONTRATADO licitar ou contratar \ncom o BNDES; \n\nX.  na  hipótese  de  caracterização  de  ato  lesivo  à  Administração  Pública,  nos \ntermos  da  Lei  nº  12.846/2013,  cometido  pelo  CONTRATADO  no  processo  de \ncontratação ou por ocasião da execução contratual; \n\nContrato OCS nº 295/2024 \nContratante: BNDES \nContratado: KRYPTUS SEGURANÇA DA INFORMAÇÃO S.A.\n\n22                                                                                                                             \n\n \n').
contract_clause(contrato_ocs_295_2024, clausula_vigesima_extincao_contrato_xi, ' \n\nClassificação: Documento Ostensivo (Lei nº 13.303/2016) \nUnidade Gestora: AJI/JULIC/GLIC4', 'XI. em razão da dissolução do CONTRATADO;  \n\nXII.  quando  da  ocorrência  de  caso  fortuito  ou  de  força  maior,  regularmente \ncomprovado, impeditivo da execução do Contrato.\n\nXIII.  por  iniciativa  do  BNDES,  a  partir  do  30º  (trigésimo)  mês  de  vigência, \ndevendo ser formalizada pelo BNDES em autorização escrita e fundamentada, \nmediante  aviso  prévio  por  escrito,  com  antecedência  mínima  de  180  (cento  e \noitenta)  dias  ou  de  prazo  menor  a  ser  negociado  pelas  partes  à  época  da \nrescisão.  \n\nParágrafo Primeiro \nCaracteriza  inadimplemento  das  obrigações  de  pagamento  pecuniário  do \npresente Contrato, a mora superior a 90 (noventa) dias.\n\nParágrafo Segundo \nOs  casos  de  extinção  contratual  convencionados  no  caput  desta  Cláusula \ndeverão  ser  precedidos  de  notificação  escrita  à  outra  parte  do  Contrato,  e  de \noportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_295_2024, clausula_vigesima_primeira_disposicoes_finais, 'CLÁUSULA VIGÉSIMA PRIMEIRA – DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto \nnele previsto.  \n\nParágrafo Primeiro \nIntegram o presente Contrato: \nAnexo I - Termo de Referência \nAnexo II - Proposta \nAnexo III - Matriz de Risco \nAnexo IV - Termo de Confidencialidade para Representante Legal \nAnexo V - Minuta de Termo de Confidencialidade para Profissionais \n\nParágrafo Segundo \nA  omissão  ou  tolerância  quanto  à  exigência  do  estrito  cumprimento  das \nobrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato \nnão constituirá renúncia ou novação nem impedirá as partes de exercerem os \nseus direitos a qualquer tempo.').

% =================================================================
% MODELO PROLOG COMPLETO - CONTRATO OCS 295/2024 (BNDES)
% Baseado na Especificação Técnica ET_295_2024
% =================================================================

% --- IDENTIFICAÇÃO E OBJETO ---
objeto(ocs_295_2024, "Serviços Especializados em Segurança Cibernética").
partes(ocs_295_2024, bndes, contratada).
vigencia_meses(60).
rescisao_antecipada_possivel(apos_30_meses).

% --- TAXONOMIA DE SERVIÇOS (ITENS) ---
servico(item_1, "CSOC - Centro de Operações de Segurança Cibernética").
servico(item_2, "Inteligência Cibernética (CTI e DRP)").

% --- FATOS DE CRITICIDADE (MAPEAMENTO DIRETO PARA OCS) ---
% Estes fatos resolvem o problema de "informação insuficiente" do seu modelo.

envolve_informacoes_sensiveis(item_1, sim).
justificativa(crit_001, "Acesso a dados de incidentes e informações sigilosas do BNDES").

suporta_processo_critico(item_1, sim).
justificativa(crit_002, "Suporte em situações de crise e indisponibilidade de ativos de TIC").

acesso_ativos_ti_criticos(item_1, sim).
justificativa(crit_003, "Monitoramento da Base de Ativos de TIC (BATIC) e servidores").

envolve_acesso_administrativo(item_1, sim).
justificativa(crit_004, "Instalação e configuração de ferramentas SOAR e Scanners no ambiente BNDES").

envolve_acesso_fisico(item_1, sim).
justificativa(crit_005, "Previsão de atendimento presencial (on-site) em caso de crise").

% --- REQUISITOS TÉCNICOS E REGRAS DE EXECUÇÃO ---

% Restrições Geográficas e Soberania de Dados
restricao_geografica(item_1, brasil, "Processamento e armazenamento em território nacional").
restricao_geografica(item_2, global, "Dados públicos/externos").

% Requisitos de Software e Infraestrutura
obrigatorio_instalar_local(soar).
obrigatorio_instalar_local(scanner_vulnerabilidade).
versao_minima_tls(1.2).

% --- REGRAS DE NEGÓCIO E CONFORMIDADE (LOGÍSICA DE CONTRATO) ---

% Regra: Proibição de Subcontratação
pode_subcontratar(ocs_295_2024) :- fail.

% Regra: Aceite e Pagamento
pode_emitir_fatura(Contratada, Mes) :-
    trabalho_realizado_no_periodo(Contratada, Mes),
    apresentou_relatorio_mensal(Contratada, Mes),
    obteve_aceite_definitivo(bndes, Mes).

% Regra: Substituição de Ferramentas
deve_substituir_ferramenta(Ferramenta, Nova) :-
    descontinuada(Ferramenta),
    equivalente_tecnica(Ferramenta, Nova),
    aprovada_pelo_gestor(bndes, Nova),
    custo_adicional(Nova, 0).

% Regra: Proteção de Dados (LGPD)
cumpre_lgpd(Contratada) :-
    mantem_log_acesso(sim),
    elimina_dados_apos_contrato(sim),
    notifica_vazamento_imediato(sim).

% --- PERFIS DE EQUIPE EXIGIDOS (EXEMPLOS) ---
perfil_exigido(coordenador_geral, superior_completo, 5_anos_experiencia).
perfil_exigido(analista_senior, certificacao_especifica, 3_anos_experiencia).

% --- ACORDOS DE NÍVEL DE SERVIÇO (SLA / IMR) ---
imr(disponibilidade_ferramentas, 99.5).
imr(tempo_resposta_incidente_critico, 30, minutos).

% ===== END =====
