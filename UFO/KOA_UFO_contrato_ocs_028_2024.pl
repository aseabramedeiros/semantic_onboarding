% ===== KOA Combined Output | contract_id: contrato_ocs_0028_2024 =====

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
% UFO-only grounding generated from: KOA_Contrato_OCS_028_2024_-_G4F_SOLUCOES_CORPORATIVAS_LTDA.pl
% contract_id: contrato_ocs_0028_2024

instance_of(contrato_ocs_0028_2024, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(g4f_solucoes_corporativas_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_0028_2024).
plays_role(g4f_solucoes_corporativas_ltda, hired_service_provider_role, contrato_ocs_0028_2024).

clause_of(clausula_primeira_objeto, contrato_ocs_0028_2024).
clause_of(clausula_segunda_vigencia, contrato_ocs_0028_2024).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_0028_2024).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_0028_2024).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_0028_2024).
clause_of(clausula_sexta_preco, contrato_ocs_0028_2024).
clause_of(clausula_setima_pagamento, contrato_ocs_0028_2024).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_0028_2024).
clause_of(clausula_decima_garantia_contratual, contrato_ocs_0028_2024).
clause_of(clausula_decima_primeira_obrigacoes_contratado, contrato_ocs_0028_2024).
clause_of(clausula_decima_segunda_obrigações_trabalhistas_e_previdenciárias_do_contratado, contrato_ocs_0028_2024).
clause_of(clausula_decima_terceira_conduta_ética_do_contratado_e_do_bndes, contrato_ocs_0028_2024).
clause_of(clausula_decima_quarta_sigilo_das_informações, contrato_ocs_0028_2024).
clause_of(clausula_decima_quinta_acesso_protecao_dados_pessoais, contrato_ocs_0028_2024).
clause_of(clausula_decima_sexta_obrigacoes_bndes, contrato_ocs_0028_2024).
clause_of(clausula_decima_setima_equidade_genero_valorizacao_diversidade, contrato_ocs_0028_2024).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_0028_2024).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, g4f_solucoes_corporativas_ltda, provide_it_services).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_it_services).
legal_relation_instance(clausula_primeira_objeto, right_to_action, g4f_solucoes_corporativas_ltda, operate_it_infrastructure).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, g4f_solucoes_corporativas_ltda, present_manifestation_about_extension).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, g4f_solucoes_corporativas_ltda, communicate_interest_in_extension).
legal_relation_instance(clausula_segunda_vigencia, subjection, g4f_solucoes_corporativas_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_segunda_vigencia, right_to_omission, g4f_solucoes_corporativas_ltda, refuse_to_celebrate_contract_addendum).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, g4f_solucoes_corporativas_ltda, submit_substitution_request).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, convene_preliminary_meeting).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, clarify_doubts).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, approve_substitution).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, g4f_solucoes_corporativas_ltda, dispose_qualified_personnel_cadastro).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, g4f_solucoes_corporativas_ltda, replace_professionals).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, g4f_solucoes_corporativas_ltda, execute_services_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_price_reduction_for_breach).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, g4f_solucoes_corporativas_ltda, be_subject_to_price_reduction).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, enforce_service_standards).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_quinta_recebimento_objeto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_sexta_preco, duty_to_act, g4f_solucoes_corporativas_ltda, bear_quantification_error_costs).
legal_relation_instance(clausula_sexta_preco, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_indemnization_for_partial_demand).
legal_relation_instance(clausula_sexta_preco, no_right_to_action, g4f_solucoes_corporativas_ltda, demand_indemnization_for_partial_demand).
legal_relation_instance(clausula_sexta_preco, duty_to_act, g4f_solucoes_corporativas_ltda, execute_contract_object).
legal_relation_instance(clausula_sexta_preco, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_executed_object).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_monthly_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, g4f_solucoes_corporativas_ltda, present_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, g4f_solucoes_corporativas_ltda, provide_labor_compliance_documentation).
legal_relation_instance(clausula_setima_pagamento, right_to_action, g4f_solucoes_corporativas_ltda, receive_monthly_payment).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, reject_out_of_time_document).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_values).
legal_relation_instance(clausula_setima_pagamento, duty_to_omit, g4f_solucoes_corporativas_ltda, not_present_out_of_time_document).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_economic_financial_balance).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_repactuation_reajuste_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, g4f_solucoes_corporativas_ltda, present_cost_information).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, g4f_solucoes_corporativas_ltda, request_price_repactuation).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, g4f_solucoes_corporativas_ltda, request_price_readjustment).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, revise_prices).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, g4f_solucoes_corporativas_ltda, request_price_revision).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, g4f_solucoes_corporativas_ltda, provide_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, subjection, g4f_solucoes_corporativas_ltda, penalty_for_failure_to_provide_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, g4f_solucoes_corporativas_ltda, obtain_guarantor_agreement).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, g4f_solucoes_corporativas_ltda, notify_guarantor_about_contract_changes).
legal_relation_instance(clausula_decima_garantia_contratual, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, accept_or_reject_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extend_guarantee_presentation_period).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, g4f_solucoes_corporativas_ltda, provide_supplementary_or_renewed_guarantee).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, g4f_solucoes_corporativas_ltda, maintain_conditions_of_qualification).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, g4f_solucoes_corporativas_ltda, communicate_imposition_of_penalty).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, g4f_solucoes_corporativas_ltda, repair_correct_remove_reconstruct_substitute).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, g4f_solucoes_corporativas_ltda, repair_damages_and_losses).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, g4f_solucoes_corporativas_ltda, pay_charges_and_taxes).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, g4f_solucoes_corporativas_ltda, assume_responsibility_for_charges).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, g4f_solucoes_corporativas_ltda, provide_exclusion_from_simples_nacional).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, g4f_solucoes_corporativas_ltda, allow_inspections_and_monitoring).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, g4f_solucoes_corporativas_ltda, obey_instructions_and_procedures).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratado, duty_to_act, g4f_solucoes_corporativas_ltda, designate_representative).
legal_relation_instance(clausula_decima_segunda_obrigações_trabalhistas_e_previdenciárias_do_contratado, duty_to_act, g4f_solucoes_corporativas_ltda, comply_with_labor_obligations).
legal_relation_instance(clausula_decima_segunda_obrigações_trabalhistas_e_previdenciárias_do_contratado, duty_to_act, g4f_solucoes_corporativas_ltda, pay_salaries).
legal_relation_instance(clausula_decima_segunda_obrigações_trabalhistas_e_previdenciárias_do_contratado, duty_to_act, g4f_solucoes_corporativas_ltda, maintain_labor_records).
legal_relation_instance(clausula_decima_segunda_obrigações_trabalhistas_e_previdenciárias_do_contratado, duty_to_act, g4f_solucoes_corporativas_ltda, provide_documentation_to_bndes).
legal_relation_instance(clausula_decima_segunda_obrigações_trabalhistas_e_previdenciárias_do_contratado, subjection, g4f_solucoes_corporativas_ltda, reimburse_bndes_for_labor_expenses).
legal_relation_instance(clausula_decima_terceira_conduta_ética_do_contratado_e_do_bndes, duty_to_act, g4f_solucoes_corporativas_ltda, maintain_integrity).
legal_relation_instance(clausula_decima_terceira_conduta_ética_do_contratado_e_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, maintain_integrity).
legal_relation_instance(clausula_decima_terceira_conduta_ética_do_contratado_e_do_bndes, duty_to_act, g4f_solucoes_corporativas_ltda, act_in_good_faith).
legal_relation_instance(clausula_decima_terceira_conduta_ética_do_contratado_e_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, act_in_good_faith).
legal_relation_instance(clausula_decima_terceira_conduta_ética_do_contratado_e_do_bndes, duty_to_act, g4f_solucoes_corporativas_ltda, follow_ethics).
legal_relation_instance(clausula_decima_terceira_conduta_ética_do_contratado_e_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, follow_ethics).
legal_relation_instance(clausula_decima_terceira_conduta_ética_do_contratado_e_do_bndes, duty_to_act, g4f_solucoes_corporativas_ltda, avoid_undue_advantage).
legal_relation_instance(clausula_decima_terceira_conduta_ética_do_contratado_e_do_bndes, duty_to_omit, g4f_solucoes_corporativas_ltda, not_offer_undue_advantage).
legal_relation_instance(clausula_decima_terceira_conduta_ética_do_contratado_e_do_bndes, duty_to_act, g4f_solucoes_corporativas_ltda, prevent_corruption).
legal_relation_instance(clausula_decima_terceira_conduta_ética_do_contratado_e_do_bndes, duty_to_act, g4f_solucoes_corporativas_ltda, prevent_favoritism).
legal_relation_instance(clausula_decima_quarta_sigilo_das_informações, duty_to_act, g4f_solucoes_corporativas_ltda, comply_with_secrecy_rules).
legal_relation_instance(clausula_decima_quarta_sigilo_das_informações, duty_to_act, g4f_solucoes_corporativas_ltda, comply_with_bndes_security_policy).
legal_relation_instance(clausula_decima_quarta_sigilo_das_informações, duty_to_omit, g4f_solucoes_corporativas_ltda, not_access_confidential_info).
legal_relation_instance(clausula_decima_quarta_sigilo_das_informações, duty_to_act, g4f_solucoes_corporativas_ltda, maintain_secrecy_of_info).
legal_relation_instance(clausula_decima_quarta_sigilo_das_informações, duty_to_act, g4f_solucoes_corporativas_ltda, limit_access_to_info).
legal_relation_instance(clausula_decima_quarta_sigilo_das_informações, duty_to_act, g4f_solucoes_corporativas_ltda, inform_bndes_of_violation).
legal_relation_instance(clausula_decima_quarta_sigilo_das_informações, duty_to_act, g4f_solucoes_corporativas_ltda, deliver_material_to_bndes).
legal_relation_instance(clausula_decima_quarta_sigilo_das_informações, duty_to_omit, g4f_solucoes_corporativas_ltda, not_use_confidential_info).
legal_relation_instance(clausula_decima_quarta_sigilo_das_informações, duty_to_act, g4f_solucoes_corporativas_ltda, present_confidentiality_terms).
legal_relation_instance(clausula_decima_quarta_sigilo_das_informações, duty_to_act, g4f_solucoes_corporativas_ltda, ensure_adhesion_to_rules).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados_pessoais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, protect_fundamental_rights).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados_pessoais, duty_to_act, g4f_solucoes_corporativas_ltda, adopt_good_governance_measures).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados_pessoais, duty_to_act, g4f_solucoes_corporativas_ltda, follow_bndes_instructions).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados_pessoais, duty_to_act, g4f_solucoes_corporativas_ltda, maintain_data_confidentiality).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados_pessoais, duty_to_act, g4f_solucoes_corporativas_ltda, store_data_securely).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados_pessoais, duty_to_act, g4f_solucoes_corporativas_ltda, inform_employees_service_providers).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados_pessoais, duty_to_act, g4f_solucoes_corporativas_ltda, provide_data_access_channel).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados_pessoais, duty_to_act, g4f_solucoes_corporativas_ltda, inform_bndes_of_requests).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados_pessoais, duty_to_act, g4f_solucoes_corporativas_ltda, maintain_records_of_data_processing).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados_pessoais, duty_to_act, g4f_solucoes_corporativas_ltda, communicate_security_incidents).
legal_relation_instance(clausula_decima_sexta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments_to_contracted_party).
legal_relation_instance(clausula_decima_sexta_obrigacoes_bndes, right_to_action, g4f_solucoes_corporativas_ltda, receive_payments_from_bndes).
legal_relation_instance(clausula_decima_sexta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager).
legal_relation_instance(clausula_decima_sexta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager_substitute).
legal_relation_instance(clausula_decima_sexta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_receiving_committee).
legal_relation_instance(clausula_decima_sexta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_access_to_ethics_code).
legal_relation_instance(clausula_decima_sexta_obrigacoes_bndes, right_to_action, g4f_solucoes_corporativas_ltda, access_to_ethics_code).
legal_relation_instance(clausula_decima_sexta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_necessary_information).
legal_relation_instance(clausula_decima_sexta_obrigacoes_bndes, right_to_action, g4f_solucoes_corporativas_ltda, receive_necessary_information).
legal_relation_instance(clausula_decima_sexta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions_or_procedures).
legal_relation_instance(clausula_decima_setima_equidade_genero_valorizacao_diversidade, duty_to_act, g4f_solucoes_corporativas_ltda, prove_absence_of_administrative_sanction).
legal_relation_instance(clausula_decima_setima_equidade_genero_valorizacao_diversidade, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_proof_of_absence_of_sanction).
legal_relation_instance(clausula_decima_setima_equidade_genero_valorizacao_diversidade, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_contract_execution).
legal_relation_instance(clausula_decima_setima_equidade_genero_valorizacao_diversidade, subjection, g4f_solucoes_corporativas_ltda, contract_execution_can_be_suspended).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, g4f_solucoes_corporativas_ltda, handle_supervening_events).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, g4f_solucoes_corporativas_ltda, respect_clause_of_economic_financial_balance).
legal_relation_instance(clausula_nona_matriz_riscos, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_handling_of_supervening_events).

% --- Action catalog (local to this contract grounding) ---
action_type(accept_or_reject_guarantee).
action_label(accept_or_reject_guarantee, 'Accept or reject guarantee').
action_type(access_to_ethics_code).
action_label(access_to_ethics_code, 'Access to ethics code').
action_type(act_in_good_faith).
action_label(act_in_good_faith, 'Act in good faith').
action_type(adopt_good_governance_measures).
action_label(adopt_good_governance_measures, 'Adopt good governance measures').
action_type(adopt_sustainable_practices).
action_label(adopt_sustainable_practices, 'Adopt sustainable practices').
action_type(allow_inspections_and_monitoring).
action_label(allow_inspections_and_monitoring, 'Allow inspections').
action_type(analyze_repactuation_reajuste_revision).
action_label(analyze_repactuation_reajuste_revision, 'Analyze repactuation request').
action_type(apply_price_reduction_for_breach).
action_label(apply_price_reduction_for_breach, 'Apply price reduction for breach').
action_type(approve_data_collection).
action_label(approve_data_collection, 'Approve data collection').
action_type(approve_substitution).
action_label(approve_substitution, 'Approve professional substitution').
action_type(assume_responsibility_for_charges).
action_label(assume_responsibility_for_charges, 'Assume responsibility').
action_type(avoid_undue_advantage).
action_label(avoid_undue_advantage, 'Avoid undue advantage').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Be subject to penalties').
action_type(be_subject_to_price_reduction).
action_label(be_subject_to_price_reduction, 'Be subject to price reduction').
action_type(bear_quantification_error_costs).
action_label(bear_quantification_error_costs, 'Bear quantification error costs').
action_type(clarify_doubts).
action_label(clarify_doubts, 'Clarify doubts').
action_type(communicate_application_of_penalty).
action_label(communicate_application_of_penalty, 'Communicate application of penalty').
action_type(communicate_imposition_of_penalty).
action_label(communicate_imposition_of_penalty, 'Communicate penalty').
action_type(communicate_instructions_or_procedures).
action_label(communicate_instructions_or_procedures, 'Communicate instructions or procedures').
action_type(communicate_interest_in_extension).
action_label(communicate_interest_in_extension, 'Communicate interest in extension').
action_type(communicate_opening_of_administrative_procedure).
action_label(communicate_opening_of_administrative_procedure, 'Communicate opening of procedure').
action_type(communicate_security_incidents).
action_label(communicate_security_incidents, 'Communicate security incidents').
action_type(comply_with_bndes_security_policy).
action_label(comply_with_bndes_security_policy, 'Comply with BNDES security policy').
action_type(comply_with_labor_obligations).
action_label(comply_with_labor_obligations, 'Comply with labor obligations').
action_type(comply_with_secrecy_rules).
action_label(comply_with_secrecy_rules, 'Comply with secrecy rules').
action_type(contract_execution_can_be_suspended).
action_label(contract_execution_can_be_suspended, 'Contract can be suspended').
action_type(control_frequency).
action_label(control_frequency, 'Control frequency').
action_type(convene_preliminary_meeting).
action_label(convene_preliminary_meeting, 'Convene preliminary meeting').
action_type(deduct_values).
action_label(deduct_values, 'Deduct values').
action_type(deliver_material_to_bndes).
action_label(deliver_material_to_bndes, 'Deliver material to BNDES').
action_type(demand_data_processing_info).
action_label(demand_data_processing_info, 'Demand data processing information').
action_type(demand_handling_of_supervening_events).
action_label(demand_handling_of_supervening_events, 'Demand handling of supervening events').
action_type(demand_indemnization_for_partial_demand).
action_label(demand_indemnization_for_partial_demand, 'No right to demand indemnization').
action_type(designate_contract_manager).
action_label(designate_contract_manager, 'Designate contract manager').
action_type(designate_contract_manager_substitute).
action_label(designate_contract_manager_substitute, 'Designate contract manager substitute').
action_type(designate_receiving_committee).
action_label(designate_receiving_committee, 'Designate receiving committee').
action_type(designate_representative).
action_label(designate_representative, 'Designate representative').
action_type(dispose_qualified_personnel_cadastro).
action_label(dispose_qualified_personnel_cadastro, 'Maintain qualified personnel registry').
action_type(effect_object_receipt).
action_label(effect_object_receipt, 'Effect object receipt').
action_type(eliminate_personal_data).
action_label(eliminate_personal_data, 'Eliminate personal data').
action_type(enforce_service_standards).
action_label(enforce_service_standards, 'Enforce service standards').
action_type(ensure_adhesion_to_rules).
action_label(ensure_adhesion_to_rules, 'Ensure adhesion to rules').
action_type(ensure_safety).
action_label(ensure_safety, 'Ensure safety').
action_type(execute_contract_object).
action_label(execute_contract_object, 'Execute contract object').
action_type(execute_services_according_to_standards).
action_label(execute_services_according_to_standards, 'Execute services to standard').
action_type(exercise_right_of_recourse).
action_label(exercise_right_of_recourse, 'Exercise right of recourse').
action_type(extend_guarantee_presentation_period).
action_label(extend_guarantee_presentation_period, 'Extend guarantee period').
action_type(follow_bndes_instructions).
action_label(follow_bndes_instructions, 'Follow BNDES instructions').
action_type(follow_ethics).
action_label(follow_ethics, 'Follow ethics').
action_type(guide_professionals).
action_label(guide_professionals, 'Guide professionals').
action_type(handle_supervening_events).
action_label(handle_supervening_events, 'Handle supervening events').
action_type(inform_bndes_of_requests).
action_label(inform_bndes_of_requests, 'Inform BNDES of requests').
action_type(inform_bndes_of_violation).
action_label(inform_bndes_of_violation, 'Inform BNDES of violation').
action_type(inform_conflict_of_interest).
action_label(inform_conflict_of_interest, 'Inform conflict of interest').
action_type(inform_employees_service_providers).
action_label(inform_employees_service_providers, 'Inform employees/service providers').
action_type(limit_access_to_info).
action_label(limit_access_to_info, 'Limit access to info').
action_type(maintain_conditions_of_qualification).
action_label(maintain_conditions_of_qualification, 'Maintain conditions').
action_type(maintain_data_confidentiality).
action_label(maintain_data_confidentiality, 'Maintain data confidentiality').
action_type(maintain_integrity).
action_label(maintain_integrity, 'Maintain integrity').
action_type(maintain_labor_records).
action_label(maintain_labor_records, 'Maintain labor records').
action_type(maintain_records_of_data_processing).
action_label(maintain_records_of_data_processing, 'Maintain records of data processing').
action_type(maintain_secrecy_of_info).
action_label(maintain_secrecy_of_info, 'Maintain secrecy of info').
action_type(make_monthly_payment).
action_label(make_monthly_payment, 'Make monthly payment').
action_type(make_payments_to_contracted_party).
action_label(make_payments_to_contracted_party, 'Make payments to contracted party').
action_type(not_access_confidential_info).
action_label(not_access_confidential_info, 'Not access confidential info').
action_type(not_allocate_family).
action_label(not_allocate_family, 'Not allocate family').
action_type(not_allow_favoritism).
action_label(not_allow_favoritism, 'Not allow favoritism').
action_type(not_offer_undue_advantage).
action_label(not_offer_undue_advantage, 'Not offer undue advantage').
action_type(not_present_out_of_time_document).
action_label(not_present_out_of_time_document, 'Do not present document out of time').
action_type(not_use_confidential_info).
action_label(not_use_confidential_info, 'Not use confidential info').
action_type(notify_guarantor_about_contract_changes).
action_label(notify_guarantor_about_contract_changes, 'Notify guarantor about changes').
action_type(notify_investigations).
action_label(notify_investigations, 'Notify investigations').
action_type(obey_instructions_and_procedures).
action_label(obey_instructions_and_procedures, 'Obey instructions').
action_type(observe_bndes_policies).
action_label(observe_bndes_policies, 'Observe BNDES policies').
action_type(obtain_guarantor_agreement).
action_label(obtain_guarantor_agreement, 'Obtain guarantor agreement').
action_type(operate_it_infrastructure).
action_label(operate_it_infrastructure, 'Operate IT Infrastructure').
action_type(pay_charges_and_taxes).
action_label(pay_charges_and_taxes, 'Pay charges and taxes').
action_type(pay_indemnization_for_partial_demand).
action_label(pay_indemnization_for_partial_demand, 'Omit paying indemnization').
action_type(pay_salaries).
action_label(pay_salaries, 'Pay salaries').
action_type(penalty_for_failure_to_provide_guarantee).
action_label(penalty_for_failure_to_provide_guarantee, 'Subject to penalty for not providing guarantee').
action_type(present_confidentiality_terms).
action_label(present_confidentiality_terms, 'Present confidentiality terms').
action_type(present_cost_information).
action_label(present_cost_information, 'Present cost information').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(present_information_declaration).
action_label(present_information_declaration, 'Present declaration').
action_type(present_manifestation_about_extension).
action_label(present_manifestation_about_extension, 'Present manifestation about extension').
action_type(prevent_corruption).
action_label(prevent_corruption, 'Prevent corruption').
action_type(prevent_family_allocation).
action_label(prevent_family_allocation, 'Prevent family allocation').
action_type(prevent_favoritism).
action_label(prevent_favoritism, 'Prevent favoritism').
action_type(protect_fundamental_rights).
action_label(protect_fundamental_rights, 'Protect fundamental rights').
action_type(prove_absence_of_administrative_sanction).
action_label(prove_absence_of_administrative_sanction, 'Prove absence of sanction').
action_type(provide_access_to_ethics_code).
action_label(provide_access_to_ethics_code, 'Provide access to ethics code').
action_type(provide_contractual_guarantee).
action_label(provide_contractual_guarantee, 'Provide contractual guarantee').
action_type(provide_data_access_channel).
action_label(provide_data_access_channel, 'Provide data access channel').
action_type(provide_documentation_to_bndes).
action_label(provide_documentation_to_bndes, 'Provide documentation to BNDES').
action_type(provide_exclusion_from_simples_nacional).
action_label(provide_exclusion_from_simples_nacional, 'Provide exclusion').
action_type(provide_it_services).
action_label(provide_it_services, 'Provide IT services').
action_type(provide_labor_compliance_documentation).
action_label(provide_labor_compliance_documentation, 'Provide labor compliance documentation').
action_type(provide_necessary_information).
action_label(provide_necessary_information, 'Provide necessary information').
action_type(provide_supplementary_or_renewed_guarantee).
action_label(provide_supplementary_or_renewed_guarantee, 'Provide supplementary guarantee').
action_type(provide_uniforms).
action_label(provide_uniforms, 'Provide uniforms').
action_type(receive_executed_object).
action_label(receive_executed_object, 'Receive executed object').
action_type(receive_it_services).
action_label(receive_it_services, 'Receive IT Services').
action_type(receive_monthly_payment).
action_label(receive_monthly_payment, 'Receive monthly payment').
action_type(receive_necessary_information).
action_label(receive_necessary_information, 'Receive necessary information').
action_type(receive_payments_from_bndes).
action_label(receive_payments_from_bndes, 'Receive payments from BNDES').
action_type(refuse_to_celebrate_contract_addendum).
action_label(refuse_to_celebrate_contract_addendum, 'Refuse to celebrate contract addendum').
action_type(reimburse_bndes_for_labor_expenses).
action_label(reimburse_bndes_for_labor_expenses, 'Reimburse BNDES labor expenses').
action_type(reject_out_of_time_document).
action_label(reject_out_of_time_document, 'Reject out of time document').
action_type(repair_correct_remove_reconstruct_substitute).
action_label(repair_correct_remove_reconstruct_substitute, 'Repair defects').
action_type(repair_damages_and_losses).
action_label(repair_damages_and_losses, 'Repair damages').
action_type(replace_professionals).
action_label(replace_professionals, 'Replace professionals').
action_type(request_economic_financial_balance).
action_label(request_economic_financial_balance, 'Request economic balance').
action_type(request_price_readjustment).
action_label(request_price_readjustment, 'Request price readjustment').
action_type(request_price_repactuation).
action_label(request_price_repactuation, 'Request price repactuation').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(request_proof_of_absence_of_sanction).
action_label(request_proof_of_absence_of_sanction, 'Request proof of absence').
action_type(respect_clause_of_economic_financial_balance).
action_label(respect_clause_of_economic_financial_balance, 'Respect Economic-Financial Balance').
action_type(revise_prices).
action_label(revise_prices, 'Revise prices').
action_type(share_or_use_data_without_authorization).
action_label(share_or_use_data_without_authorization, 'Not to share/use data without authorization').
action_type(store_data_securely).
action_label(store_data_securely, 'Store data securely').
action_type(submit_substitution_request).
action_label(submit_substitution_request, 'Submit substitution request to BNDES').
action_type(suspend_contract_execution).
action_label(suspend_contract_execution, 'Suspend contract execution').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_0028_2024).
contract_metadata(contrato_ocs_0028_2024, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇOS').
contract_metadata(contrato_ocs_0028_2024, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'G4F SOLUÇÕES CORPORATIVAS LTDA']).
contract_metadata(contrato_ocs_0028_2024, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_0028_2024, contratado, 'G4F SOLUÇÕES CORPORATIVAS LTDA').
contract_metadata(contrato_ocs_0028_2024, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_0028_2024, cnpj_contratado, '07.094.346/0001-45').
contract_metadata(contrato_ocs_0028_2024, procedimento_licitatorio, 'Pregão Eletrônico nº 11/2023 - BNDES').
contract_metadata(contrato_ocs_0028_2024, data_autorizacao, '09/08/2023').
contract_metadata(contrato_ocs_0028_2024, ip_ati_degat, '09/2023').
contract_metadata(contrato_ocs_0028_2024, rubrica_orcamentaria, '3101700090').
contract_metadata(contrato_ocs_0028_2024, centro_custo, 'BN00004000').
contract_metadata(contrato_ocs_0028_2024, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_0028_2024, regulamento, 'Regulamento Licitações e Contratos das empresas Integrantes do Sistema BNDES').
contract_clause(contrato_ocs_0028_2024, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a prestação continuada de serviços de operação da infraestrutura de tecnologia da informação (TI) do BNDES, conforme especificações constantes do Termo de Referência (Anexo I do Edital do Pregão Eletrônico nº 11/2023 - BNDES) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_0028_2024, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 30 (trinta) meses, a contar da data de sua assinatura, podendo ser prorrogado, mediante aditivo,  até o limite total de 60 (sessenta) meses.  Parágrafo Primeiro O CONTRATADO deverá, no prazo de até 5 (cinco) dias úteis, contados da notificação do Gestor do Contrato, apresentar, por intermédio do seu Representante Legal, sua manifestação sobre a prorrogação do Contrato.  Parágrafo Segundo Independente da notificação do parágrafo anterior, o CONTRATADO deverá comunicar ao Gestor seu interesse quanto à prorrogação do contrato até 90 (noventa) dias antes do término de cada período de vigência contratual.  Parágrafo Terceiro A formalização da prorrogação será efetuada por meio de aditivo epistolar, dispensando-se a assinatura do CONTRATADO  Parágrafo Quarto Caso o CONTRATADO se recuse a celebrar aditivo contratual de prorrogação, tendo antes manifestado sua intenção de prorrogar o Contrato ou deixado de manifestar seu propósito de não prorrogar, nos termos do Parágrafo Primeiro desta Cláusula, ficará sujeito às penalidades previstas na Cláusula de Penalidades deste Contrato.').
contract_clause(contrato_ocs_0028_2024, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes do Termo de Referência (Anexo I deste Contrato) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.  Parágrafo Primeiro O BNDES convocará o CONTRATADO a comparecer à reunião preliminar. Nesta reunião o BNDES esclarecerá ao CONTRATADO todas as dúvidas relativas à execução do objeto, disponibilizando eventuais documentos necessários ao início dos trabalhos, observando-se o disposto no Termo de Referência (Anexo I deste Contrato).  Parágrafo Segundo O CONTRATADO deverá dispor de cadastro de pessoal qualificado para proceder à substituição dos profissionais alocados na execução dos serviços, observado o disposto a seguir: I. a substituição deverá ser realizada em até 20 (vinte) dias úteis; II. o substituto deverá possuir perfil igual ou superior ao do profissional substituído; III. o CONTRATADO deverá submeter ao BNDES um pedido de substituição, indicando o substituto e o profissional a ser substituído, bem como o período de substituição se for o caso. A este pedido deverá ser anexada a documentação que comprove o perfil profissional do substituto, nos termos do Anexo I (Termo de Referência) deste Contrato; IV. a substituição somente poderá ser realizada após a aprovação pelo BNDES;  V. aprovada a substituição, o CONTRATADO deverá apresentar os documentos necessários.').
contract_clause(contrato_ocs_0028_2024, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'Os serviços contratados deverão ser executados de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados pelo BNDES, observados os níveis de serviço descritos no Anexo I (Termo de Referência) deste Contrato.  Parágrafo Único O descumprimento dos níveis de serviço acarretará a aplicação dos índices de redução do preço previstos no Anexo I (Termo de Referência) deste Contrato, sem prejuízo da aplicação das penalidades previstas neste Contrato, quando cabíveis.').
contract_clause(contrato_ocs_0028_2024, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do Plano de Implantação, dos serviços relativos ao período de transição e relativos à operação assistida através da Comissão de Recebimento, e os serviços relativos à operação plena, pelo gestor do contrato, mencionados na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo I (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_0028_2024, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará ao CONTRATADO, pela execução do objeto contratado, o valor de até R$ 11.985.000,00 (onze milhões e novecentos e oitenta e cinco mil reais), conforme proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento.  Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização ao CONTRATADO.   Parágrafo Quarto O CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato;').
contract_clause(contrato_ocs_0028_2024, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento mensalmente, por meio de crédito em conta bancária, em até 10 (dez) dias úteis, a contar da data de apresentação do documento fiscal ou equivalente legal (prioritariamente  nota fiscal, e nos casos de dispensa da nota fiscal: fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Termo de Referência) deste Instrumento.  Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte, seguinte da prestação do serviço/fornecimento do bem.  Parágrafo Segundo A apresentação do documento de cobrança fora do prazo previsto nesta cláusula poderá implicar em sua rejeição e no direito do BNDES se ressarcir, preferencialmente, mediante desconto do valor a ser pago ao CONTRATADO, por qualquer penalidade tributária incidente pelo atraso.  Parágrafo Terceiro Nas hipóteses em que o recebimento definitivo ocorrer após a entrega do documento fiscal ou equivalente legal, o BNDES terá até 10 (dez) dias úteis, a contar da data em que o objeto tiver sido recebido definitivamente, para efetuar o pagamento.  Parágrafo Quarto O primeiro documento fiscal ou equivalente legal terá como objeto de cobrança o período compreendido entre o dia de início da prestação dos serviços e o último dia desse mês, e os documentos fiscais ou equivalentes legais subsequentes terão como referência o período compreendido entre o primeiro e o último dia de cada mês. O último documento fiscal ou equivalente legal, por seu turno, referir-se-á ao período compreendido entre o primeiro dia do último mês da prestação dos serviços e o último dia de serviço prestado. Em todos os casos, o documento fiscal ou equivalente legal só poderá ser emitido e apresentado ao BNDES após a efetiva prestação do serviço, respeitado o disposto no Parágrafo anterior.  Parágrafo Quinto Para toda efetivação de pagamento, o Contratado deverá encaminhar o documento fiscal ou equivalente em meio digital para caixa postal eletrônica ou protocolar em sistema eletrônico próprio do BNDES, considerando as orientações do Contratante vigentes na ocasião do pagamento. No caso de emissão de documento fiscal exclusivamente em meio físico o mesmo deverá ser encaminhado ao protocolo do BNDES para devido registro de recebimento.  Parágrafo Sexto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações:  I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor do Contrato; V. descrição detalhada do objeto executado e dos respectivos valores; VI. período de referência da execução do objeto; VII. nome e número do CNPJ do CONTRATADO, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VIII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; IX. nome e número do banco e da agência, bem como o número da conta corrente da CONTRATADO, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; X. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; XI. CNPJ do tomador do serviço: 33.657.248/0001-89; XII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XIII. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento - DIF; XIV. número de inscrição do contribuinte individual válido junto ao INSS (NIT ou PIS/PASEP); e  XV. destaque das retenções tributárias aplicáveis, conforme estabelecido na DIF.   Parágrafo Sétimo Os pagamentos a serem efetuados em favor do CONTRATADO estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pelo CONTRATADO. Em casos de dispensa ou benefício fiscal que implique em redução ou eliminação da retenção de tributos, o CONTRATADO fornecerá todos os documentos comprobatórios.  Parágrafo Oitavo O CONTRATADO deverá destacar no documento fiscal ou equivalente legal os valores relativos ao fornecimento de material equipamentos, vale-transporte e auxílio-alimentação, para que o BNDES possa proceder à retenção dos encargos previdenciários e demais tributos, atinentes a cada parcela, na forma determinada pela legislação e regulamentos administrativos aplicáveis.  Parágrafo Nono O documento fiscal ou equivalente legal emitido pelo CONTRATADO deverá estar em conformidade com a legislação do Município onde o CONTRATADO esteja estabelecida, cuja regularidade fiscal foi avaliada na etapa de habilitação, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos, sob pena de devolução do documento e interrupção do prazo para pagamento.   Parágrafo Décimo Ao documento fiscal ou equivalente legal deverão ser anexados: I. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade;  II. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado;   Parágrafo Décimo Primeiro Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal ao CONTRATADO ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Décimo Segundo Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pelo CONTRATADO.  Parágrafo Décimo Terceiro O pagamento mensal pelo BNDES ocorrerá após a verificação do cumprimento das obrigações trabalhistas, previdenciárias e para com o Fundo de Garantia do Tempo de Serviço - FGTS pelo CONTRATADO relativas aos empregados do CONTRATADO que tenham participado da execução dos serviços, em especial, quanto:  a) ao pagamento de salários, adicionais, horas extras, repouso semanal remunerado e décimo terceiro salário; b) à concessão de férias remuneradas e ao pagamento do respectivo adicional; c) à concessão do auxílio-transporte, auxílio-alimentação e auxílio-saúde, quando for devido; d) aos depósitos do FGTS; e e) ao pagamento de obrigações trabalhistas e previdenciárias dos empregados dispensados até a data da extinção do contrato.  Parágrafo Décimo Quarto Para possibilitar a verificação do cumprimento das obrigações trabalhistas, previdenciárias e para com o Fundo de Garantia do Tempo de Serviço – FGTS, deverão ser apresentados ao BNDES, a respectiva documentação relativa à competência que está sendo faturada: I. Comprovantes de adimplemento dos salários e benefícios, relativos ao mês faturado; II. Guia de Recolhimento do Fundo de Garantia do Tempo de Serviço e de Informações à Previdência Social – GFIP, acompanhada da respectiva Relação de Trabalhadores constantes do arquivo SEFIP, relativos ao mês faturado; e III. Demais documentos que se façam necessários para cumprimento das obrigações envolvidas.  Parágrafo Décimo Quinto Caso não seja apresentada a documentação comprobatória do cumprimento das obrigações trabalhistas (inclusive FGTS) e previdenciárias, o BNDES comunicará o fato ao CONTRATADO e poderá reter o pagamento da fatura mensal, em valor proporcional ao da obrigação cujo adimplemento não tenha sido comprovado, até que a situação seja regularizada.  Parágrafo Décimo Sexto Na hipótese do Parágrafo anterior, não sendo regularizada a situação no prazo de 15 (quinze) dias, o BNDES, sem prejuízo das penalidades cabíveis, inclusive a rescisão do contrato, poderá efetuar o pagamento das respectivas obrigações diretamente aos profissionais alocados à prestação de serviço, não configurando vínculo empregatício ou implicando em assunção de responsabilidades por quaisquer obrigações dele decorrentes entre o BNDES e os empregados do CONTRATADO. O sindicato representante da categoria dos trabalhadores será notificado para acompanhar o referido pagamento.  Parágrafo Décimo Sétimo Na situação prevista no parágrafo anterior deve o CONTRATADO fornecer ao BNDES de imediato todas as informações e documentos necessários para a efetivação do pagamento direto.   Parágrafo Décimo Oitavo Na impossibilidade de pagamento direto pelo BNDES, os valores retidos poderão ser depositados junto à Justiça do Trabalho, com o objetivo de serem utilizados exclusivamente no pagamento de salários e das demais verbas trabalhistas, contribuições sociais e FGTS.  Parágrafo Décimo Nono Os pagamentos efetuados pelo BNDES diretamente ou através da Justiça do Trabalho aos empregados do CONTRATADO equivalerá para todos os fins de direito à quitação, na exata medida dos pagamentos ou depósitos efetuados, às suas obrigações decorrentes do presente Contrato perante o CONTRATADO.  Parágrafo Vigésimo  Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível ao CONTRATADO, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.  Parágrafo Vigésimo Primeiro Fica assegurado ao BNDES o direito de deduzir do pagamento devido ao CONTRATADO, por força deste Contrato ou de outro contrato mantido com o BNDES, o valor correspondente aos pagamentos efetuados a maior ou em duplicidade.').
contract_clause(contrato_ocs_0028_2024, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO O BNDES e o CONTRATADO têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante repactuação, reajuste ou revisão de preços.  Parágrafo Primeiro A repactuação de preços, na forma prevista na legislação, poderá ser requerida pelo CONTRATADO a cada período de 12 (doze) meses, sendo o primeiro contado do dia 05/10/2023, data limite para a apresentação da proposta (Anexo II deste Contrato), ou da data do orçamento a que a proposta se referir, e os seguintes da data do fato gerador anterior, observando-se que: I. no que tange aos custos decorrentes de mão de obra, determinados por norma coletiva de trabalho, será adotada como data do orçamento a que a proposta se referir e como data do fato gerador anterior à data dos instrumentos coletivos mencionados vigentes à época da proposta ou da repactuação anterior, vedada a inclusão, por ocasião da repactuação, de antecipações e benefícios não previstos originariamente, exceto quando se tornarem obrigatórios por força de instrumento legal ou norma coletiva de trabalho; II. no que diz respeito aos insumos reajustados de acordo com os valores de mercado, o prazo mínimo de 12 (doze) meses para a realização da primeira repactuação de preços será contado da data limite para a apresentação da proposta (Anexo II do Contrato) e, para a realização das repactuações seguintes, o prazo será contado a partir do fato gerador da última repactuação; III. caso o intervalo entre os fatos geradores seja inferior a 120 (cento e vinte) dias, os pedidos de repactuação poderão ser reunidos em um só procedimento, considerando-se o último fato gerador para a aplicação do inciso I do Parágrafo Quarto desta Cláusula IV. a repactuação será precedida de demonstração analítica do aumento dos custos; V. o CONTRATADO deverá apresentar planilhas de custos comparativas entre a data da formulação da proposta/orçamento e o momento do pedido de repactuação, contemplando os custos unitários envolvidos, evidenciando o quanto o aumento de preços ocorrido repercute no valor contratual então vigente; e VI. deverão ser apresentados os documentos comprobatórios do aumento de custo, tais como, norma coletiva de trabalho, indicadores setoriais, tabelas de fabricantes, valores oficiais de referência e tarifas públicas.   Parágrafo Segundo O reajuste de preços, na forma prevista na legislação, poderá ser requerido pelo CONTRATADO a cada período de 12 (doze) meses, sendo o primeiro contado do dia 05/10/2023, data de apresentação da proposta (Anexo II deste Contrato), e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do Índice de Serviços de Telecomunicações (IST) em relação aos 2 (dois) aparelhos telefônicos celulares (smartphones) solicitados como insumos, bem como o Índice de Custo da Tecnologia da Informação (ICTI) para os demais insumos de infraestrutura que constem da proposta, sobre o preço referido na Cláusula de Preço deste Instrumento.  Parágrafo Terceiro A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta ou da última repactuação e do momento do pedido de revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ou da última repactuação e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Quarto Independentemente de solicitação, o BNDES poderá convocar o CONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.   Parágrafo Quinto O CONTRATADO deverá solicitar a repactuação, reajuste e/ou a revisão de preços até a prorrogação ou o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador da repactuação, da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias da prorrogação ou do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da divulgação do índice, para solicitar a repactuação, reajuste e/ou a revisão de preços; II. caso a assinatura do aditivo de prorrogação torne superveniente a ocorrência do fato gerador da repactuação e/ou a divulgação do índice de reajuste ocorra após a prorrogação ou o encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da divulgação do índice, para solicitar a repactuação ou o reajuste; III. o BNDES deverá analisar o pedido de repactuação, reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso o CONTRATADO não solicite a repactuação, reajuste e/ou revisão de preços nos prazos fixados acima, não fará jus aos efeitos retroativos ou, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito à repactuação, reajuste e/ou à revisão.  Parágrafo Quinto O registro do acordo ou convenção coletiva é um requisito para a concessão da repactuação correlata pelo BNDES, cumprindo ao CONTRATADO, na hipótese de celebração de convenção coletiva, notificar judicial ou extrajudicialmente o sindicato competente para a promoção do registro, caso este não o faça em prazo razoável, para que seja deferida a repactuação.  Parágrafo Sexto Se o processo de repactuação, reajuste e/ou revisão de preços não for concluído até o vencimento do Contrato, e este for prorrogado, sua continuidade após o reequilíbrio econômico-financeiro ficará condicionada à manutenção da proposta do CONTRATADO como a condição mais vantajosa para o BNDES, podendo este: I. realizar negociação de preços junto ao CONTRATADO, de forma a viabilizar a continuidade do ajuste, quando os novos valores fixados após a repactuação, reajuste e/ou a revisão de preços estiverem acima do patamar apurado no mercado; ou  II. rescindir o Contrato, mediante aviso prévio ao CONTRATADO, com antecedência de 30 (trinta) dias, quando resultar infrutífera a negociação indicada no Inciso anterior.  Parágrafo Sétimo Na ocorrência da hipótese prevista no Inciso II do Parágrafo anterior, o CONTRATADO fará jus à integralidade dos valores apurados no processo de repactuação, reajuste e/ou revisão de preços até o término do Contrato, não podendo, todavia, reclamar qualquer indenização em razão da rescisão do mesmo.', 'clausula_oitava_equilibrio_economico_financeiro_contrato').
contract_clause(contrato_ocs_0028_2024, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.    Parágrafo Primeiro A repactuação aludida na Matriz de Riscos deve respeitar o disposto na
contract_clause(contrato_ocs_0028_2024, clausula_decima_garantia_contratual, 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL  O CONTRATADO prestará, no prazo de até 10 (dez) dias úteis, contados da convocação, garantia contratual, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para sua aceitação estipuladas nos incisos abaixo, no valor de R$ 599.250,00 (quinhentos e noventa e nove mil, duzentos e cinquenta reais), que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas quando da referida convocação; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a) O Instrumento de Apólice de Seguro deve prever expressamente: a.1) responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas ao CONTRATADO; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a) O Instrumento de Fiança deve prever expressamente: a.1) renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pelo CONTRATADO durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Havendo majoração do preço contratado, decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, fica dispensada a atualização da garantia, salvo se o valor da atualização for igual ou superior ao patamar referenciado no inciso II do artigo 91 do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Terceiro Nos demais casos que demandem a complementação ou renovação da garantia, tais como alteração do objeto (aditivo quantitativo ou qualitativo), prorrogação contratual, dentre outros, o CONTRATADO deverá providenciá-la no prazo estipulado pelo BNDES.   Parágrafo Quarto Sempre que o contrato for garantido por fiança bancária ou seguro garantia, o CONTRATADO deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe ao CONTRATADO obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.  Parágrafo Quinto A garantia contratual deverá cobrir: I. todas as obrigações decorrentes do objeto contratual, assim como eventuais danos decorrentes de seu descumprimento; II. todas as obrigações relacionadas ao objeto principal, ainda que decorrentes de sua manutenção e/ou refazimento, bem como das medidas necessárias à prevenção ordinária de sinistros, prejuízos e danos em geral; III. prejuízos decorrentes de atos de corrupção praticados sem participação dolosa do BNDES ou de seus representantes; IV. prejuízos diretos causados ao BNDES decorrentes de culpa ou dolo durante a execução do Contrato; V. multas moratórias e/ou punitivas aplicadas pelo BNDES ao CONTRATADO;  VI. obrigações trabalhistas e previdenciárias de qualquer natureza, não adimplidas pelo CONTRATADO, quando o objeto contratual demandar cessão de mão de obra com dedicação exclusiva.  Parágrafo Sexto Em caso de prorrogação da vigência ou alteração do objeto contratual, o CONTRATADO deverá notificar a entidade fiadora/seguradora, conforme o caso, no prazo de até 10 (dez) dias úteis, contados da formalização do respectivo Instrumento Contratual.  Parágrafo Sétimo Por se tratar de garantia contratual prestada em benefício de uma Estatal, caso os documentos de caução, fiança ou seguro façam referência à Lei nº 8.666/1993 e/ou à Lei nº 14.133/2021, aplicam-se as disposições respectivas da Lei nº 13.303/2016, no que couber.', 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL  O CONTRATADO prestará, no prazo de até 10 (dez) dias úteis, contados da convocação, garantia contratual, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para sua aceitação estipuladas nos incisos abaixo, no valor de R$ 599.250,00 (quinhentos e noventa e nove mil, duzentos e cinquenta reais), que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas quando da referida convocação; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a) O Instrumento de Apólice de Seguro deve prever expressamente: a.1) responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas ao CONTRATADO; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a) O Instrumento de Fiança deve prever expressamente: a.1) renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pelo CONTRATADO durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Havendo majoração do preço contratado, decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, fica dispensada a atualização da garantia, salvo se o valor da atualização for igual ou superior ao patamar referenciado no inciso II do artigo 91 do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Terceiro Nos demais casos que demandem a complementação ou renovação da garantia, tais como alteração do objeto (aditivo quantitativo ou qualitativo), prorrogação contratual, dentre outros, o CONTRATADO deverá providenciá-la no prazo estipulado pelo BNDES.   Parágrafo Quarto Sempre que o contrato for garantido por fiança bancária ou seguro garantia, o CONTRATADO deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe ao CONTRATADO obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.  Parágrafo Quinto A garantia contratual deverá cobrir: I. todas as obrigações decorrentes do objeto contratual, assim como eventuais danos decorrentes de seu descumprimento; II. todas as obrigações relacionadas ao objeto principal, ainda que decorrentes de sua manutenção e/ou refazimento, bem como das medidas necessárias à prevenção ordinária de sinistros, prejuízos e danos em geral; III. prejuízos decorrentes de atos de corrupção praticados sem participação dolosa do BNDES ou de seus representantes; IV. prejuízos diretos causados ao BNDES decorrentes de culpa ou dolo durante a execução do Contrato; V. multas moratórias e/ou punitivas aplicadas pelo BNDES ao CONTRATADO;  VI. obrigações trabalhistas e previdenciárias de qualquer natureza, não adimplidas pelo CONTRATADO, quando o objeto contratual demandar cessão de mão de obra com dedicação exclusiva.  Parágrafo Sexto Em caso de prorrogação da vigência ou alteração do objeto contratual, o CONTRATADO deverá notificar a entidade fiadora/seguradora, conforme o caso, no prazo de até 10 (dez) dias úteis, contados da formalização do respectivo Instrumento Contratual.  Parágrafo Sétimo Por se tratar de garantia contratual prestada em benefício de uma Estatal, caso os documentos de caução, fiança ou seguro façam referência à Lei nº 8.666/1993 e/ou à Lei nº 14.133/2021, aplicam-se as disposições respectivas da Lei nº 13.303/2016, no que couber.').
contract_clause(contrato_ocs_0028_2024, clausula_decima_primeira_obrigacoes_contratado, 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DO CONTRATADO Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação e a ausência de impedimentos exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que venha a emitir em desacordo com a legislação aplicável. VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; X. apresentar, em até 10 (dez) dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; XI. orientar os profissionais alocados na execução dos serviços para que se comportem de forma cordial, e que estejam sempre dentro dos padrões de apresentação e higiene compatíveis com os serviços; XII. controlar a frequência, a assiduidade e a pontualidade dos empregados alocados na execução dos serviços, descontando do preço as faltas e os atrasos com base em relatório mensal de frequência; XIII. fornecer uniformes a cada um dos empregados alocados na prestação dos serviços, sem quaisquer ônus para eles, observadas as especificações e quantidades previstas no item 16.6.3 do Anexo I (Termo de Referência) deste Instrumento; XIV. zelar pela segurança dos profissionais alocados na execução dos serviços, responsabilizando-se por quaisquer acidentes, em serviço, de que venham a ser vítimas; XV. Comprovar, mensalmente e a qualquer tempo por solicitação do BNDES, o pagamento dos salários, dos adicionais, das férias e do 13º salário dos profissionais através da apresentação ao BNDES, do comprovante de depósito; XVI. fornecer, sempre que solicitado pelo BNDES, comprovação documental do conteúdo das informações apresentadas na planilha de custos e formação de preços, efetuando os ajustes necessários; XVII. atender às solicitações do BNDES relativas à transição contratual entre o CONTRATADO e o seu sucessor na execução dos serviços, prestando todo o suporte, inclusive a capacitação dos profissionais de seu sucessor, a fim de que o objeto contratado não seja interrompido;  XVIII. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo o CONTRATADO ser instado a intervir no processo;  XIX.  responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos serviços, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES; XX. devolver, ao final do Contrato, os crachás de identificação fornecidos pelo BNDES; XXI. responsabilizar-se pela investigação de antecedentes sociais dos profissionais alocados na execução dos serviços, podendo o BNDES exigir, a qualquer tempo, sua comprovação; XXII. devolver recursos disponibilizados pelo BNDES, revogar perfis de acesso de seus profissionais, eliminar suas caixas postais e adotar demais providências aplicáveis ao término da vigência deste Contrato; XXIII. não efetuar a compilação reversa, montagem reversa ou engenharia reversa de qualquer programa aplicativo do BNDES ou de terceiros a que venha ter acesso por força do serviço. XXIV. manter vínculo empregatício em regime CLT para todos os profissionais envolvidos na prestação dos serviços; XXV. responder, em relação aos seus profissionais, por todas as despesas decorrentes da execução dos serviços, tais como: salários, seguros de acidente, taxas, impostos, contribuições, indenizações, vales-refeição, vales-transporte e outras que porventura venham a ser criadas e exigidas por este contrato, pelo Poder Público ou no instrumento coletivo da categoria; XXVI. observar os salários de todas as categorias profissionais envolvidas na prestação do serviço, conforme os definidos por meio da legislação aplicável ou por meio do respectivo instrumento coletivo; XXVII. não usar, copiar, duplicar ou de alguma outra forma reproduzir ou reter todas ou quaisquer informações do BNDES, exceto se autorizada previamente, por escrito, pelo BNDES. XXVIII. manter sigilo relativamente ao objeto contratado, bem como sobre dados, documentos, especificações técnicas ou comerciais e demais informações, não tornadas públicas pelo BNDES, de que venha a ter conhecimento em virtude da contratação, sendo vedada a divulgação das informações obtidas a terceiros em geral, e em especial a quaisquer meios de comunicação públicos e/ou privados; XXIX. cumprir e obedecer a Política Corporativa de Segurança da Informação do BNDES;', 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DO CONTRATADO Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação e a ausência de impedimentos exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que venha a emitir em desacordo com a legislação aplicável. VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; X. apresentar, em até 10 (dez) dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; XI. orientar os profissionais alocados na execução dos serviços para que se comportem de forma cordial, e que estejam sempre dentro dos padrões de apresentação e higiene compatíveis com os serviços; XII. controlar a frequência, a assiduidade e a pontualidade dos empregados alocados na execução dos serviços, descontando do preço as faltas e os atrasos com base em relatório mensal de frequência; XIII. fornecer uniformes a cada um dos empregados alocados na prestação dos serviços, sem quaisquer ônus para eles, observadas as especificações e quantidades previstas no item 16.6.3 do Anexo I (Termo de Referência) deste Instrumento; XIV. zelar pela segurança dos profissionais alocados na execução dos serviços, responsabilizando-se por quaisquer acidentes, em serviço, de que venham a ser vítimas; XV. Comprovar, mensalmente e a qualquer tempo por solicitação do BNDES, o pagamento dos salários, dos adicionais, das férias e do 13º salário dos profissionais através da apresentação ao BNDES, do comprovante de depósito; XVI. fornecer, sempre que solicitado pelo BNDES, comprovação documental do conteúdo das informações apresentadas na planilha de custos e formação de preços, efetuando os ajustes necessários; XVII. atender às solicitações do BNDES relativas à transição contratual entre o CONTRATADO e o seu sucessor na execução dos serviços, prestando todo o suporte, inclusive a capacitação dos profissionais de seu sucessor, a fim de que o objeto contratado não seja interrompido;  XVIII. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo o CONTRATADO ser instado a intervir no processo;  XIX.  responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos serviços, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES; XX. devolver, ao final do Contrato, os crachás de identificação fornecidos pelo BNDES; XXI. responsabilizar-se pela investigação de antecedentes sociais dos profissionais alocados na execução dos serviços, podendo o BNDES exigir, a qualquer tempo, sua comprovação; XXII. devolver recursos disponibilizados pelo BNDES, revogar perfis de acesso de seus profissionais, eliminar suas caixas postais e adotar demais providências aplicáveis ao término da vigência deste Contrato; XXIII. não efetuar a compilação reversa, montagem reversa ou engenharia reversa de qualquer programa aplicativo do BNDES ou de terceiros a que venha ter acesso por força do serviço. XXIV. manter vínculo empregatício em regime CLT para todos os profissionais envolvidos na prestação dos serviços; XXV. responder, em relação aos seus profissionais, por todas as despesas decorrentes da execução dos serviços, tais como: salários, seguros de acidente, taxas, impostos, contribuições, indenizações, vales-refeição, vales-transporte e outras que porventura venham a ser criadas e exigidas por este contrato, pelo Poder Público ou no instrumento coletivo da categoria; XXVI. observar os salários de todas as categorias profissionais envolvidas na prestação do serviço, conforme os definidos por meio da legislação aplicável ou por meio do respectivo instrumento coletivo; XXVII. não usar, copiar, duplicar ou de alguma outra forma reproduzir ou reter todas ou quaisquer informações do BNDES, exceto se autorizada previamente, por escrito, pelo BNDES. XXVIII. manter sigilo relativamente ao objeto contratado, bem como sobre dados, documentos, especificações técnicas ou comerciais e demais informações, não tornadas públicas pelo BNDES, de que venha a ter conhecimento em virtude da contratação, sendo vedada a divulgação das informações obtidas a terceiros em geral, e em especial a quaisquer meios de comunicação públicos e/ou privados; XXIX. cumprir e obedecer a Política Corporativa de Segurança da Informação do BNDES.').
contract_clause(contrato_ocs_0028_2024, clausula_decima_segunda_obrigações_trabalhistas_e_previdenciárias_do_contratado, 'CLÁUSULA DÉCIMA SEGUNDA – OBRIGAÇÕES TRABALHISTAS E PREVIDENCIÁRIAS DO CONTRATADO', 'O CONTRATADO deverá cumprir todas as obrigações trabalhistas e previdenciárias relativas aos profissionais designados para a prestação de serviço, observando, especialmente, as obrigações seguintes:  I. pagar os salários e demais verbas passadas diretamente ao profissional, por depósito na conta bancária do mesmo aberta pelo CONTRATADO para esse fim, em estabelecimento de crédito próximo ao local de trabalho, no prazo; II. pagar os salários e os insumos dos profissionais alocados na execução dos serviços, de acordo com os valores indicados na planilha de custos e formação de preços; III. observar as obrigações previstas na norma coletiva aplicável à categoria profissional do empregado, inclusive no que diz respeito a pisos salariais; IV.  cumprir as obrigações trabalhistas de acordo com os valores e especificações indicados na planilha de custos e formação de preços (contida na proposta – Anexo II deste Instrumento); V. atender a legislação relativa à segurança e à medicina do trabalho, e em particular as Normas Regulamentadoras (NR) expedidas pelo Ministério do Trabalho e Emprego; VI. pagar antecipadamente, em parcela única mensal, os insumos referentes a vale-transporte e auxílio-alimentação.  Parágrafo Primeiro Devem ser mantidos e atualizados pelo CONTRATADO, bem como exibidos por meio de cópias eletrônicas, sempre que solicitadas pelo BNDES, os registros, anotações e documentos que comprovem o cumprimento das obrigações trabalhistas e previdenciárias, tais como:  I. o contrato de trabalho, o regulamento interno da empresa, se houver, a norma coletiva aplicável à categoria profissional do empregado; II. o registro do profissional e a carteira de trabalho e previdência social – CTPS devidamente assinada; III. o Atestado de Saúde Ocupacional (ASO), comprovando a realização das avaliações médicas (admissional, periódica, demissional e, se for o caso, de retorno ao trabalho e de mudança de função) e exames complementares determinados pelo médico do trabalho; IV. documento comprobatório do cadastramento do profissional no regime do PIS/PASEP; V. documento comprobatório do pagamento das contribuições previdenciárias dos empregados e do empregador; VI. cartão, ficha ou livro de ponto assinado pelo profissional, ou documento comprobatório do registro eletrônico de ponto, nos quais constem as horas trabalhadas normais e extraordinárias, se for o caso; VII. recibo de concessão de aviso de férias, a ser dado 30 (trinta) dias antes do respectivo gozo; VIII. documento comprobatório de depósito bancário na conta do profissional referente ao pagamento dos salários mensais e adicionais aplicáveis, férias acrescidas do terço constitucional e décimo terceiro salário (primeira e segunda parcelas); IX. documento comprobatório de pagamento do salário-família, caso devido, por depósito bancário na conta do profissional, aberta nos termos do Inciso I do caput desta Cláusula; X. documento comprobatório de opção e fornecimento de vale-transporte, quando for o caso; XI. documento comprobatório de fornecimento de auxílio-alimentação;  XII. documento comprobatório de recolhimento das contribuições devidas aos sindicatos; XIII. documento comprobatório de entrega e do conteúdo da Relação Anual de Informações Sociais (RAIS); XIV. documento que ateste o recebimento pelo profissional de equipamentos de proteção individual ou coletiva, se o serviço assim o exigir; XV. documento comprobatório do recolhimento dos valores devidos ao FGTS nas respectivas contas vinculadas dos profissionais; XVI. documento comprobatório da entrega e do conteúdo do Cadastro Geral de Empregados e Desempregados (CAGED); XVII. cópia da folha de pagamento analítica de qualquer mês da prestação do serviço, em que conste como tomador o BNDES;  XVIII. cópia dos contracheques dos profissionais alocados na execução do serviço, relativos a qualquer mês da prestação de serviço  XIX. documento comprobatório de realização de eventuais cursos de treinamento e reciclagem que forem exigidos por lei ou por este Contrato  XX. em caso de demissão ou rescisão de contrato de trabalho, os seguintes documentos: a) termos que cuidem da demissão ou rescisão do contrato, sua respectiva homologação e quitação de verbas rescisórias, na forma da legislação; b) documento comprobatório da concessão de aviso prévio pelo CONTRATADO ou pelo profissional; c) documento comprobatório da entrega dos documentos necessários à obtenção de seguro-desemprego pelo profissional, nas hipóteses em que o mesmo faça jus ao benefício; d) guias de recolhimento do FGTS e das contribuições sociais devidas;  e) extratos dos depósitos efetuados nas contas vinculadas individuais do FGTS de cada profissional dispensado; e  f) Atestado de Saúde Ocupacional (ASO), comprovando a realização do exame médico demissional, quando exigível.  Parágrafo Segundo Fica estabelecido que o CONTRATADO é considerado, para todos os fins e efeitos jurídicos, como único e exclusivo empregador dos profissionais alocados à prestação de serviço, sendo o responsável pelo cumprimento das obrigações trabalhistas e previdenciárias, cabendo-lhe reembolsar o BNDES ou suas subsidiárias de todas as despesas que estes tiverem, inclusive custas, emolumentos e honorários advocatícios, resultantes de sua condenação judicial a honrar obrigações trabalhistas ou previdenciárias, ou ainda a pagar indenizações decorrentes das relações de trabalho.').
contract_clause(contrato_ocs_0028_2024, clausula_decima_terceira_conduta_ética_do_contratado_e_do_bndes, 'CLÁUSULA DÉCIMA TERCEIRA- CONDUTA ÉTICA DO CONTRATADO E DO BNDES', 'O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar a Política para Transações com Partes Relacionadas e o Código de Ética do Sistema BNDES vigentes ao tempo da contratação, bem como a Política Corporativa de Integridade do Sistema BNDES, assegurando-se de que seus representantes, administradores, todos os profissionais envolvidos na execução do objeto e eventuais subcontratados pautem seu comportamento e sua atuação pelos princípios neles constantes;  V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição;  VI. informar imediatamente ao BNDES a ocorrência de potencial situação de conflito de interesses, comunicando na mesma oportunidade as medidas que serão adotadas para o tratamento da questão; e VII. notificar imediatamente o BNDES sobre qualquer investigação ou procedimento iniciado por autoridade governamental relacionado à violação de Leis Anticorrupção (nacional ou estrangeira) e/ou de obrigações da empresa, de seus administradores, diretores, prepostos, empregados, representantes ou terceiros a seu serviço, incluindo subcontratados, referentes a este Contrato.  Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política Corporativa de Integridade do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_0028_2024, clausula_decima_quarta_sigilo_das_informações, 'CLÁUSULA DÉCIMA QUARTA – SIGILO DAS INFORMAÇÕES', 'Cabe ao CONTRATADO cumprir as seguintes regras de sigilo e assegurar a aceitação e adesão às mesmas por profissionais que integrem ou venham a integrar a sua equipe na prestação do objeto deste Contrato, as quais perdurarão, inclusive, após a cessação do vínculo contratual e da prestação dos serviços: I. cumprir as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES, necessárias para assegurar a integridade e o sigilo das informações;  II. não acessar informações sigilosas do BNDES, salvo quando previamente autorizado por escrito; III. sempre que tiver acesso às informações mencionadas no inciso anterior: a) manter sigilo dessas informações, não podendo copiá-las, reproduzi-las, retê-las ou praticar qualquer outra forma de uso que não seja imprescindível para a adequada prestação do objeto deste Contrato; b) limitar o acesso às informações aos profissionais envolvidos na prestação dos serviços objeto deste Contrato, os quais deverão estar cientes da natureza sigilosa das informações e das obrigações e responsabilidades decorrentes do uso dessas informações; e c) informar imediatamente ao BNDES qualquer violação das regras de sigilo ora estabelecidas que tenha ocorrido por sua ação ou omissão, independentemente da existência de dolo, bem como dos profissionais envolvidos, adotando todas as orientações do BNDES para remediar a violação; IV. entregar ao BNDES, ao término da vigência deste Contrato, todo e qualquer material de propriedade deste, inclusive notas pessoais envolvendo matéria sigilosa e registro de documentos de qualquer natureza que tenham sido criados, usados ou mantidos sob seu controle ou posse, assumindo o compromisso de não utilizar qualquer informação sigilosa a que teve acesso no âmbito deste Contrato;  V. apresentar, em até 10 (dez) dias úteis, após a convocação do gestor do contrato, Termos de Confidencialidade, conforme minuta constante do Anexo V (Minuta de Termo de Confidencialidade para Profissionais) deste Contrato, assinados pelos profissionais que acessarão informações sigilosas, devendo referida obrigação ser também cumprida por ocasião de substituição desses profissionais; e VI. observar o disposto no Termo de Confidencialidade assinado por seu Representante Legal constante do Anexo IV (Minuta de Termo de Confidencialidade e Tratamento de Dados Pessoais para Contratos Administrativos) deste Contrato.').
contract_clause(contrato_ocs_0028_2024, clausula_decima_quinta_acesso_protecao_dados_pessoais, 'CLÁUSULA DÉCIMA QUINTA – ACESSO E PROTEÇÃO DE DADOS PESSOAIS', 'As partes assumem o compromisso de proteger os direitos fundamentais de liberdade e de privacidade, relativos ao tratamento de dados pessoais, nos meios físicos e digitais, devendo, para tanto, adotar medidas de boa governança sob o aspecto técnico, jurídico e administrativo, inclusive de segurança, e observar que:    I.Eventual tratamento de dados pessoais em razão do presente Contrato deverá ser realizado conforme os parâmetros previstos na legislação, especialmente na Lei n° 13.709/2018 – Lei Geral de Proteção de Dados Pessoais - LGPD, dentro de propósitos legítimos, específicos, explícitos e informados ao titular;   II.O tratamento será limitado às atividades necessárias ao atingimento das finalidades contratuais e, caso seja necessário, ao cumprimento de suas obrigações legais ou regulatórias, sejam de ordem principal ou acessória, observando-se que, em caso de necessidade de coleta de dados pessoais diretamente pelo CONTRATADO, esta será realizada mediante prévia aprovação do BNDES, responsabilizando-se o CONTRATADO por obter o consentimento dos titulares, salvo nos casos em que a legislação dispense tal medida;  III.O CONTRATADO deverá seguir as instruções recebidas do BNDES em relação ao tratamento de dados pessoais;  IV.No caso de tratamento de dados pessoais realizado pelo CONTRATADO para cumprimento de suas obrigações legais ou para atendimento de suas próprias finalidades, o BNDES não será considerado “Controlador de Dados Pessoais” e, sim, o CONTRATADO;  V.Os dados coletados somente poderão ser utilizados pelas partes, seus representantes, empregados e prestadores de serviços diretamente alocados na execução contratual, sendo que, em hipótese alguma, poderão ser compartilhados ou utilizados para outros fins, sem a prévia autorização do BNDES, ou caso haja alguma ordem judicial, observando-se as medidas legalmente previstas para tanto;  VI.O CONTRATADO deve manter a confidencialidade dos dados pessoais obtidos em razão do presente contrato, devendo adotar as medidas técnicas e administrativas adequadas e necessárias, visando assegurar a proteção dos dados, nos termos do artigo 46 da LGPD, de modo a garantir um nível apropriado de segurança e a prevenção e mitigação de eventuais riscos;  VII.Os dados deverão ser armazenados de maneira segura pelo CONTRATADO, que utilizará recursos de segurança da informação e tecnologia adequados, inclusive quanto a mecanismos de detecção e prevenção de ataques cibernéticos e incidentes de segurança da informação.   VIII.O CONTRATADO dará conhecimento formal para seus empregados e/ou prestadores de serviço acerca das disposições previstas nesta Cláusula e na Cláusula de Sigilo das Informações, responsabilizando-se por eventual uso indevido dos dados pessoais, bem como por quaisquer falhas nos sistemas por ela empregados para o tratamento dos dados.  IX.O BNDES possui direito de regresso em face do CONTRATADO em razão de eventuais danos causados por este em decorrência do descumprimento das responsabilidades e obrigações previstas no âmbito deste contrato e da Lei Geral de Proteção de Dados Pessoais;  X.O CONTRATADO deverá disponibilizar ao titular do dado um canal ou sistema em que seja garantida consulta facilitada e gratuita sobre a forma, a duração do tratamento e a integralidade de seus dados pessoais.  XI.O CONTRATADO deverá informar imediatamente ao BNDES todas as solicitações recebidas em razão do exercício dos direitos pelo titular dos dados relacionados a este Contrato, seguindo as orientações fixadas pelo BNDES e pela legislação em vigor para o adequado endereçamento das demandas.  XII.O CONTRATADO deverá manter registro de todas as operações de tratamento de dados pessoais que realizar no âmbito do Contrato disponibilizando, sempre que solicitado pelo BNDES, as informações necessárias à produção do Relatório de Impacto de Dados Pessoais, disposto no artigo 5º, XVII, da Lei Geral de Proteção de Dados Pessoais.  XIII.Qualquer incidente ao qual o CONTRATADO tiver dado causa e que implique em violação ou risco de violação ou vazamento de dados pessoais deverá ser prontamente comunicado ao BNDES, informando-se também todas as providências adotadas e os dados pessoais eventualmente afetados, cabendo ao CONTRATADO disponibilizar as informações e documentos solicitados e colaborar com qualquer investigação ou auditoria que venha a ser realizada.  XIV.Ao final da vigência do Contrato, o CONTRATADO deverá eliminar de sua base de informações todo e qualquer dado pessoal que tenha tido acesso em razão da execução do objeto contratado, salvo quando tenha que manter a informação para o cumprimento de obrigação legal.  Parágrafo Primeiro  As Partes reconhecem que, se durante a execução do Contrato armazenarem, coletarem, tratarem ou de qualquer outra forma processarem dados pessoais, no sentido dado pela legislação vigente aplicável, o BNDES será considerado “Controlador de Dados”, e o CONTRATADO “Operador” ou “Processador de Dados”, salvo nas situações expressas em contrário nesse Contrato. Contudo, caso o CONTRATADO descumpra as obrigações prevista na legislação de proteção de dados ou as instruções do BNDES, será equiparado a “Controlador de Dados”, inclusive para fins de sua responsabilização por eventuais danos causados.  Parágrafo Segundo Cada uma das Partes será controladora independente, para os fins desse CONTRATO, cabendo definir individualmente as bases legais apropriadas e diretrizes para as operações de tratamento, em relação aos seguintes dados pessoais: (i) que vierem a coletar diretamente junto aos respectivos titulares, desde que essa operação de tratamento se dê com base em suas próprias decisões; (ii) oriundos de suas próprias bases de dados; e (iii) relativos ao seu corpo de colaboradores, funcionários e/ou prepostos envolvidos para a regular execução deste Contrato.  Parágrafo Terceiro Caso o CONTRATADO disponibilize dados de terceiros, além das obrigações no caput desta Cláusula, deve se responsabilizar por eventuais danos que o BNDES venha a sofrer em decorrência de uso indevido de dados pessoais por parte do CONTRATADO, sempre que ficar comprovado que houve falha de segurança técnica e administrativa, descumprimento de regras previstas na legislação de proteção à privacidade e dados pessoais, e das orientações do BNDES, sem prejuízo das penalidades deste Contrato.  Parágrafo Quarto A assinatura deste Contrato importa na manifestação de inequívoco consentimento do titular, seja ele pessoa física direta ou indiretamente relacionada ao CONTRATADO, inclusive sócios, representantes legais, empregados, contratados e/ou terceirizados, quando for o caso, dos dados pessoais que tenham se tornados públicos como condição para participação na licitação e para contratação, para tratamento pelo BNDES, na forma da Lei nº 13.709/2018. Poderão ser solicitados pelo BNDES dados pessoais adicionais a fim de viabilizar o cumprimento de obrigação legal.  Parágrafo Quinto Os representantes legais signatários do presente autorizam a divulgação dos dados pessoais expressamente contidos nos documentos decorrentes do procedimento de licitação, tais como nome, CPF, e-mail, telefone e cargo, para fins de publicidade das contratações administrativas no site institucional do BNDES e em cumprimento à Lei nº 12.527/ 2011 (Lei de Acesso à Informação).  Parágrafo Sexto As partes comprometem-se a coletar o consentimento, quando necessário, conforme previsto na Lei nº 13.709/2018 (Lei Geral de Proteção de Dados Pessoais - LGPD), bem como informar aos titulares dos dados pessoais mencionados no presente instrumento, para as finalidades descritas no parágrafo acima.').
contract_clause(contrato_ocs_0028_2024, clausula_decima_sexta_obrigacoes_bndes, 'CLÁUSULA DÉCIMA SEXTA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos ao CONTRATADO, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Marcelo Pinto do Nascimento, que atualmente exerce a função de Coordenador de Serviço da Gerência de Produção da ATI (ATI/DESET/GPRO), a quem caberá o acompanhamento, a fiscalização e a avaliação da execução dos serviços, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. designar, como substituto do Gestor do Contrato, para atuar em sua eventual ausência, Fabrício dos Anjos Silva, Leonardo Ferreira Moura ou Otávio Frederico da Costa Roma Scheidegger; IV. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita ao CONTRATADO;  V. designar a Comissão de Recebimento, a quem caberá o recebimento do objeto, em conjunto com o Gestor do Contrato;  VI. fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, acesso ao Código de Ética do Sistema BNDES, da Política Corporativa de Integridade do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; VII. colocar à disposição do CONTRATADO todas as informações necessárias à perfeita execução dos serviços objeto deste Contrato; e VIII. comunicar ao CONTRATADO, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares do CONTRATADO, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_0028_2024, clausula_decima_setima_equidade_genero_valorizacao_diversidade, 'CLÁUSULA DÉCIMA SÉTIMA – EQUIDADE DE GÊNERO E VALORIZAÇÃO DA DIVERSIDADE', 'O CONTRATADO deverá comprovar, sempre que solicitado pelo BNDES, a inexistência de decisão administrativa final sancionadora, exarada por autoridade ou órgão competente, em razão da prática de atos, pelo próprio CONTRATADO ou dirigentes, administradores ou sócios majoritários, que importem em discriminação de raça ou gênero, exploração irregular, ilegal ou criminosa do trabalho infantil ou prática relacionada ao trabalho em condições análogas à escravidão, e de sentença condenatória transitada em julgado, proferida em decorrência dos referidos atos, e, se for o caso, de outros que caracterizem assédio moral ou sexual e importem em crime contra o meio ambiente.   Parágrafo Primeiro Na hipótese de ter havido decisão administrativa e/ou sentença condenatória, nos termos referidos no caput desta Cláusula, a execução do objeto contratual poderá ser suspensa pelo BNDES até a comprovação do cumprimento da reparação imposta ou da reabilitação do CONTRATADO ou de seus dirigentes, conforme o caso.    Parágrafo Segundo A comprovação a que se refere o caput desta Cláusula será realizada por meio de declaração, sem prejuízo da verificação do sistema informativo interno do BNDES – Sistema de Gerenciamento do Cadastro de Entidades (N02), acerca da inexistência de sanção em face do CONTRATADO e/ou de seus dirigentes, administradores ou sócios majoritários que impeça a contratação.').

% ===== END =====
