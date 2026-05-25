% ===== KOA Combined Output | contract_id: contrato_ocs_0118_2022 =====

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
% UFO-only grounding generated from: KOA_Contrato_OCS_118_2022_-_Algar_(0800).pl
% contract_id: contrato_ocs_0118_2022

instance_of(contrato_ocs_0118_2022, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(algar_telecom_s_a, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_0118_2022).
plays_role(algar_telecom_s_a, hired_service_provider_role, contrato_ocs_0118_2022).

clause_of(clausula_primeira_objeto, contrato_ocs_0118_2022).
clause_of(clausula_segunda_vigencia, contrato_ocs_0118_2022).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_0118_2022).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_0118_2022).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_0118_2022).
clause_of(clausula_sexta_preco, contrato_ocs_0118_2022).
clause_of(clausula_setima_pagamento, contrato_ocs_0118_2022).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_0118_2022).
clause_of(clausula_decima_obrigacoes_contratado, contrato_ocs_0118_2022).
clause_of(clausula_decima_primeira_conduta_etica, contrato_ocs_0118_2022).
clause_of(clausula_decima_segunda_sigilo, contrato_ocs_0118_2022).
clause_of(clausula_decima_terceira_acesso_e_protecao_de_dados_pessoais, contrato_ocs_0118_2022).
clause_of(clausula_decima_quarta_obrigacoes_do_bndes, contrato_ocs_0118_2022).
clause_of(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, contrato_ocs_0118_2022).
clause_of(clausula_decima_setima_penalidades, contrato_ocs_0118_2022).
clause_of(clausula_decima_oitava_alteracoes_contratuais, contrato_ocs_0118_2022).
clause_of(clausula_decima_nona_extincao_contrato, contrato_ocs_0118_2022).
clause_of(clausula_vigésima_disposicoes_finais, contrato_ocs_0118_2022).
clause_of(clausula_vigésima_primeira_foro, contrato_ocs_0118_2022).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_0118_2022).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, algar_telecom_s_a, provide_fixed_line_telephone_service).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_fixed_line_telephone_service).
legal_relation_instance(clausula_primeira_objeto, right_to_action, algar_telecom_s_a, receive_payment_for_fixed_line_service).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, algar_telecom_s_a, apresentar_manifestacao_prorrogacao).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, algar_telecom_s_a, comunicar_interesse_prorrogacao).
legal_relation_instance(clausula_segunda_vigencia, subjection, algar_telecom_s_a, sujeitar_se_as_penalidades).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, algar_telecom_s_a, execute_contract_according_specifications).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_execution_according_specifications).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, algar_telecom_s_a, execute_services_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, algar_telecom_s_a, be_subject_to_price_reduction).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, stipulate_service_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_price_reduction_indices).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_services_executed_according_to_standards).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_object).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, unknown, receive_object_through_gestor).
legal_relation_instance(clausula_quinta_recebimento_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_object).
legal_relation_instance(clausula_sexta_preco, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_indemnization_if_no_demand_total).
legal_relation_instance(clausula_sexta_preco, no_right_to_action, algar_telecom_s_a, receive_indemnization_if_no_demand_total).
legal_relation_instance(clausula_sexta_preco, duty_to_act, algar_telecom_s_a, bear_costs_of_quantification_errors).
legal_relation_instance(clausula_sexta_preco, no_right_to_omission, algar_telecom_s_a, omit_bearing_costs_of_quantification_errors).
legal_relation_instance(clausula_sexta_preco, subjection, algar_telecom_s_a, accept_reduction_due_to_partial_execution).
legal_relation_instance(clausula_sexta_preco, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, reduce_payment_due_to_partial_execution).
legal_relation_instance(clausula_sexta_preco, duty_to_act, algar_telecom_s_a, execute_contract_object).
legal_relation_instance(clausula_sexta_preco, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_payment_for_execution).
legal_relation_instance(clausula_setima_pagamento, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_direct_payment_to_subcontractors).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effectuate_payment).
legal_relation_instance(clausula_setima_pagamento, right_to_action, algar_telecom_s_a, receive_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, algar_telecom_s_a, present_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, reject_late_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_payments).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, have_right_to_economic_financial_balance).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, algar_telecom_s_a, request_price_readjustment).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, initiate_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, algar_telecom_s_a, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, algar_telecom_s_a, submit_contract_revision_request).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, algar_telecom_s_a, present_cost_unit_spreadsheets).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, call_for_price_reduction_negotiation).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, algar_telecom_s_a, present_requested_information).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, algar_telecom_s_a, request_price_readjustment_or_revision_before_contract_end).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_readjustment_revision_request).
legal_relation_instance(clausula_decima_obrigacoes_contratado, duty_to_act, algar_telecom_s_a, maintain_qualification_conditions).
legal_relation_instance(clausula_decima_obrigacoes_contratado, duty_to_act, algar_telecom_s_a, notify_impediment).
legal_relation_instance(clausula_decima_obrigacoes_contratado, duty_to_act, algar_telecom_s_a, repair_defects).
legal_relation_instance(clausula_decima_obrigacoes_contratado, duty_to_act, algar_telecom_s_a, repair_damages).
legal_relation_instance(clausula_decima_obrigacoes_contratado, duty_to_act, algar_telecom_s_a, pay_taxes).
legal_relation_instance(clausula_decima_obrigacoes_contratado, duty_to_act, algar_telecom_s_a, bear_fiscal_burdens).
legal_relation_instance(clausula_decima_obrigacoes_contratado, duty_to_act, algar_telecom_s_a, prove_exclusion_from_simples).
legal_relation_instance(clausula_decima_obrigacoes_contratado, duty_to_act, algar_telecom_s_a, allow_inspections).
legal_relation_instance(clausula_decima_obrigacoes_contratado, duty_to_act, algar_telecom_s_a, obey_instructions).
legal_relation_instance(clausula_decima_obrigacoes_contratado, duty_to_act, algar_telecom_s_a, designate_representative).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, algar_telecom_s_a, not_offer_undue_advantage).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_omit, algar_telecom_s_a, offer_undue_advantage).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, algar_telecom_s_a, prevent_favoritism).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_omit, algar_telecom_s_a, allow_favoritism).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, algar_telecom_s_a, not_allocate_bndes_family).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_omit, algar_telecom_s_a, allocate_bndes_family).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, algar_telecom_s_a, remove_agents_with_impediments).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, algar_telecom_s_a, report_impediments).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, algar_telecom_s_a, prevent_administrators_from_corruption).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, algar_telecom_s_a, observe_bndes_policies).
legal_relation_instance(clausula_decima_segunda_sigilo, duty_to_act, algar_telecom_s_a, comply_with_bndes_information_security_policy).
legal_relation_instance(clausula_decima_segunda_sigilo, duty_to_omit, algar_telecom_s_a, not_access_confidential_information).
legal_relation_instance(clausula_decima_segunda_sigilo, duty_to_act, algar_telecom_s_a, maintain_confidentiality_of_information).
legal_relation_instance(clausula_decima_segunda_sigilo, duty_to_act, algar_telecom_s_a, limit_access_to_information).
legal_relation_instance(clausula_decima_segunda_sigilo, duty_to_act, algar_telecom_s_a, inform_bndes_of_violation).
legal_relation_instance(clausula_decima_segunda_sigilo, duty_to_act, algar_telecom_s_a, return_materials_to_bndes).
legal_relation_instance(clausula_decima_segunda_sigilo, duty_to_omit, algar_telecom_s_a, not_use_confidential_info_after_contract).
legal_relation_instance(clausula_decima_segunda_sigilo, duty_to_act, algar_telecom_s_a, present_confidentiality_terms).
legal_relation_instance(clausula_decima_terceira_acesso_e_protecao_de_dados_pessoais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, protect_fundamental_rights).
legal_relation_instance(clausula_decima_terceira_acesso_e_protecao_de_dados_pessoais, duty_to_act, algar_telecom_s_a, follow_bndes_instructions).
legal_relation_instance(clausula_decima_terceira_acesso_e_protecao_de_dados_pessoais, duty_to_act, algar_telecom_s_a, maintain_confidentiality).
legal_relation_instance(clausula_decima_terceira_acesso_e_protecao_de_dados_pessoais, duty_to_act, algar_telecom_s_a, store_data_securely).
legal_relation_instance(clausula_decima_terceira_acesso_e_protecao_de_dados_pessoais, duty_to_act, algar_telecom_s_a, inform_employees).
legal_relation_instance(clausula_decima_terceira_acesso_e_protecao_de_dados_pessoais, duty_to_act, algar_telecom_s_a, provide_data_access_channel).
legal_relation_instance(clausula_decima_terceira_acesso_e_protecao_de_dados_pessoais, duty_to_act, algar_telecom_s_a, inform_bndes_of_requests).
legal_relation_instance(clausula_decima_terceira_acesso_e_protecao_de_dados_pessoais, duty_to_act, algar_telecom_s_a, maintain_data_operation_records).
legal_relation_instance(clausula_decima_terceira_acesso_e_protecao_de_dados_pessoais, duty_to_act, algar_telecom_s_a, communicate_incidents).
legal_relation_instance(clausula_decima_terceira_acesso_e_protecao_de_dados_pessoais, duty_to_act, algar_telecom_s_a, eliminate_data_at_end).
legal_relation_instance(clausula_decima_quarta_obrigacoes_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments_to_contracted_party).
legal_relation_instance(clausula_decima_quarta_obrigacoes_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager).
legal_relation_instance(clausula_decima_quarta_obrigacoes_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_documents_upon_request).
legal_relation_instance(clausula_decima_quarta_obrigacoes_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_information_for_service_execution).
legal_relation_instance(clausula_decima_quarta_obrigacoes_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions_or_procedures).
legal_relation_instance(clausula_decima_quarta_obrigacoes_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_administrative_procedure_initiation).
legal_relation_instance(clausula_decima_quarta_obrigacoes_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_penalty_application).
legal_relation_instance(clausula_decima_quarta_obrigacoes_do_bndes, right_to_action, algar_telecom_s_a, receive_payments_from_bndes).
legal_relation_instance(clausula_decima_quarta_obrigacoes_do_bndes, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, change_contract_manager).
legal_relation_instance(clausula_decima_quarta_obrigacoes_do_bndes, right_to_action, algar_telecom_s_a, obtain_documents_from_bndes).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, algar_telecom_s_a, cannot_assign_contract).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, algar_telecom_s_a, cannot_assign_credit).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, algar_telecom_s_a, cannot_issue_credit_title).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, permission_to_act, algar_telecom_s_a, succeed_contract).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, subjection, algar_telecom_s_a, obtain_bndes_approval_succession).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, duty_to_act, algar_telecom_s_a, maintain_contract_conditions_succession).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, permission_to_act, algar_telecom_s_a, subcontract_object).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, subjection, algar_telecom_s_a, obtain_bndes_approval_subcontract).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, duty_to_act, algar_telecom_s_a, meet_contract_conditions_subcontract).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, duty_to_act, algar_telecom_s_a, present_proof_bndes).
legal_relation_instance(clausula_decima_setima_penalidades, subjection, algar_telecom_s_a, be_subject_to_penalties).
legal_relation_instance(clausula_decima_setima_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_setima_penalidades, duty_to_act, algar_telecom_s_a, request_reconsideration).
legal_relation_instance(clausula_decima_setima_penalidades, right_to_action, algar_telecom_s_a, request_reconsideration_action).
legal_relation_instance(clausula_decima_setima_penalidades, duty_to_act, algar_telecom_s_a, interpose_resource).
legal_relation_instance(clausula_decima_setima_penalidades, right_to_action, algar_telecom_s_a, interpose_resource_action).
legal_relation_instance(clausula_decima_oitava_alteracoes_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, modify_contract).
legal_relation_instance(clausula_decima_oitava_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_alteration).
legal_relation_instance(clausula_decima_oitava_alteracoes_contratuais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, claim_damages_refusal_to_modify).
legal_relation_instance(clausula_decima_oitava_alteracoes_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, compensate_damages_refusal_to_modify).
legal_relation_instance(clausula_decima_nona_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_for_breach).
legal_relation_instance(clausula_decima_nona_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_for_contractor_bankruptcy).
legal_relation_instance(clausula_decima_nona_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_for_loss_of_qualification).
legal_relation_instance(clausula_decima_nona_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_for_cession_breach).
legal_relation_instance(clausula_decima_nona_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_for_dishonesty_declaration).
legal_relation_instance(clausula_decima_nona_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_for_bndes_suspension).
legal_relation_instance(clausula_decima_nona_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_for_corruption).
legal_relation_instance(clausula_decima_nona_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_for_dissolution).
legal_relation_instance(clausula_decima_nona_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_for_force_majeure).
legal_relation_instance(clausula_decima_nona_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_other_party_of_termination).
legal_relation_instance(clausula_vigésima_disposicoes_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights).
legal_relation_instance(clausula_vigésima_disposicoes_finais, right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_demanding_strict_compliance).
legal_relation_instance(clausula_vigésima_disposicoes_finais, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_strict_compliance).
legal_relation_instance(clausula_vigésima_primeira_foro, power, unknown, choose_rio_de_janeiro_court).
legal_relation_instance(clausula_vigésima_primeira_foro, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, be_subject_to_rio_de_janeiro_court).
legal_relation_instance(clausula_vigésima_primeira_foro, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, litigate_in_another_forum).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, algar_telecom_s_a, respect_economic_financial_equilibrium_clause).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_omit, algar_telecom_s_a, omit_additives_for_allocated_risks).
legal_relation_instance(clausula_nona_matriz_riscos, no_right_to_action, algar_telecom_s_a, no_right_additives_for_allocated_risks).

% --- Action catalog (local to this contract grounding) ---
action_type(accept_reduction_due_to_partial_execution).
action_label(accept_reduction_due_to_partial_execution, 'Accept payment reduction').
action_type(adopt_sustainable_practices).
action_label(adopt_sustainable_practices, 'Adopt sustainable practices').
action_type(allocate_bndes_family).
action_label(allocate_bndes_family, 'Omit allocating BNDES family').
action_type(allow_favoritism).
action_label(allow_favoritism, 'Omit allowing favoritism').
action_type(allow_inspections).
action_label(allow_inspections, 'Allow inspections').
action_type(analyze_readjustment_revision_request).
action_label(analyze_readjustment_revision_request, 'analyze readjustment/revision request').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_price_reduction_indices).
action_label(apply_price_reduction_indices, 'Apply price reduction indices').
action_type(apresentar_manifestacao_prorrogacao).
action_label(apresentar_manifestacao_prorrogacao, 'Present manifestation about extension').
action_type(attend_transition_requests).
action_label(attend_transition_requests, 'Attend transition requests').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Be subject to penalties').
action_type(be_subject_to_price_reduction).
action_label(be_subject_to_price_reduction, 'Be subject to price reduction').
action_type(be_subject_to_rio_de_janeiro_court).
action_label(be_subject_to_rio_de_janeiro_court, 'Subject to Rio court').
action_type(bear_costs_of_quantification_errors).
action_label(bear_costs_of_quantification_errors, 'Bear cost of errors').
action_type(bear_fiscal_burdens).
action_label(bear_fiscal_burdens, 'Bear fiscal burdens').
action_type(break_integrity).
action_label(break_integrity, 'Omit Breaking Integrity').
action_type(call_for_price_reduction_negotiation).
action_label(call_for_price_reduction_negotiation, 'call for price reduction negotiation').
action_type(cannot_assign_contract).
action_label(cannot_assign_contract, 'Cannot assign contract').
action_type(cannot_assign_credit).
action_label(cannot_assign_credit, 'Cannot assign credit').
action_type(cannot_issue_credit_title).
action_label(cannot_issue_credit_title, 'Cannot issue credit title').
action_type(change_contract_manager).
action_label(change_contract_manager, 'Change contract manager').
action_type(choose_rio_de_janeiro_court).
action_label(choose_rio_de_janeiro_court, 'Choose Rio court').
action_type(claim_damages_refusal_to_modify).
action_label(claim_damages_refusal_to_modify, 'Claim damages for refusal').
action_type(collect_consent_when_necessary).
action_label(collect_consent_when_necessary, 'Collect consent when necessary').
action_type(communicate_administrative_procedure_initiation).
action_label(communicate_administrative_procedure_initiation, 'Communicate admin procedure').
action_type(communicate_incidents).
action_label(communicate_incidents, 'Communicate incidents').
action_type(communicate_instructions_or_procedures).
action_label(communicate_instructions_or_procedures, 'Communicate instructions').
action_type(communicate_penalty_application).
action_label(communicate_penalty_application, 'Communicate penalty').
action_type(compensate_damages_refusal_to_modify).
action_label(compensate_damages_refusal_to_modify, 'Compensate for damages').
action_type(comply_security_rules).
action_label(comply_security_rules, 'Comply security rules').
action_type(comply_with_bndes_information_security_policy).
action_label(comply_with_bndes_information_security_policy, 'Comply with BNDES security policy').
action_type(comunicar_interesse_prorrogacao).
action_label(comunicar_interesse_prorrogacao, 'Communicate interest about extension').
action_type(deduct_payments).
action_label(deduct_payments, 'Deduct from payments').
action_type(demand_execution_according_specifications).
action_label(demand_execution_according_specifications, 'Demand execution as specified').
action_type(demand_strict_compliance).
action_label(demand_strict_compliance, 'Demand compliance').
action_type(designate_contract_manager).
action_label(designate_contract_manager, 'Designate contract manager').
action_type(designate_representative).
action_label(designate_representative, 'Designate representative').
action_type(effectuate_payment).
action_label(effectuate_payment, 'Effectuate payment').
action_type(eliminate_data_at_end).
action_label(eliminate_data_at_end, 'Eliminate data at end').
action_type(execute_contract_according_specifications).
action_label(execute_contract_according_specifications, 'Execute contract as specified').
action_type(execute_contract_object).
action_label(execute_contract_object, 'Execute contract object').
action_type(execute_services_according_to_standards).
action_label(execute_services_according_to_standards, 'Execute services to standards').
action_type(exercise_rights).
action_label(exercise_rights, 'Exercise rights').
action_type(expect_services_executed_according_to_standards).
action_label(expect_services_executed_according_to_standards, 'Expect services executed to standards').
action_type(follow_bndes_instructions).
action_label(follow_bndes_instructions, 'Follow BNDES instructions').
action_type(formalize_contract_alteration).
action_label(formalize_contract_alteration, 'Formalize contract change').
action_type(have_right_to_economic_financial_balance).
action_label(have_right_to_economic_financial_balance, 'have right to economic-financial balance').
action_type(inform_bndes_of_requests).
action_label(inform_bndes_of_requests, 'Inform BNDES of requests').
action_type(inform_bndes_of_violation).
action_label(inform_bndes_of_violation, 'Inform BNDES of violation').
action_type(inform_employees).
action_label(inform_employees, 'Inform employees').
action_type(initiate_price_revision).
action_label(initiate_price_revision, 'initiate price revision').
action_type(interpose_resource).
action_label(interpose_resource, 'Interpose resource').
action_type(interpose_resource_action).
action_label(interpose_resource_action, 'Right to interpose resource').
action_type(limit_access_to_information).
action_label(limit_access_to_information, 'Limit access to information').
action_type(litigate_in_another_forum).
action_label(litigate_in_another_forum, 'No right to litigate elsewhere').
action_type(maintain_confidentiality).
action_label(maintain_confidentiality, 'Maintain confidentiality').
action_type(maintain_confidentiality_of_information).
action_label(maintain_confidentiality_of_information, 'Maintain confidentiality').
action_type(maintain_contract_conditions_succession).
action_label(maintain_contract_conditions_succession, 'Maintain contract conditions').
action_type(maintain_data_operation_records).
action_label(maintain_data_operation_records, 'Maintain data operation records').
action_type(maintain_integrity).
action_label(maintain_integrity, 'Maintain Integrity').
action_type(maintain_qualification_conditions).
action_label(maintain_qualification_conditions, 'Maintain qualification conditions').
action_type(make_payments_to_contracted_party).
action_label(make_payments_to_contracted_party, 'Make payments').
action_type(meet_contract_conditions_subcontract).
action_label(meet_contract_conditions_subcontract, 'Meet contract conditions (subcontract)').
action_type(modify_contract).
action_label(modify_contract, 'Modify contract').
action_type(no_right_additives_for_allocated_risks).
action_label(no_right_additives_for_allocated_risks, 'No right to additives for allocated risks').
action_type(not_access_confidential_information).
action_label(not_access_confidential_information, 'Not access confidential information').
action_type(not_allocate_bndes_family).
action_label(not_allocate_bndes_family, 'Not allocate BNDES family').
action_type(not_offer_undue_advantage).
action_label(not_offer_undue_advantage, 'Not offer undue advantage').
action_type(not_use_confidential_info_after_contract).
action_label(not_use_confidential_info_after_contract, 'Not use confidential information').
action_type(notify_impediment).
action_label(notify_impediment, 'Notify impediment').
action_type(notify_other_party_of_termination).
action_label(notify_other_party_of_termination, 'Notify termination').
action_type(obey_instructions).
action_label(obey_instructions, 'Obey instructions').
action_type(observe_bndes_policies).
action_label(observe_bndes_policies, 'Observe BNDES policies').
action_type(obtain_bndes_approval_subcontract).
action_label(obtain_bndes_approval_subcontract, 'Obtain BNDES approval (subcontract)').
action_type(obtain_bndes_approval_succession).
action_label(obtain_bndes_approval_succession, 'Obtain BNDES approval (succession)').
action_type(obtain_documents_from_bndes).
action_label(obtain_documents_from_bndes, 'Obtain documents').
action_type(offer_undue_advantage).
action_label(offer_undue_advantage, 'Omit offering undue advantage').
action_type(omit_additives_for_allocated_risks).
action_label(omit_additives_for_allocated_risks, 'Omit additives for allocated risks').
action_type(omit_bearing_costs_of_quantification_errors).
action_label(omit_bearing_costs_of_quantification_errors, 'No right to omit cost').
action_type(omit_demanding_strict_compliance).
action_label(omit_demanding_strict_compliance, 'Omit demanding strict compliance').
action_type(omit_direct_payment_to_subcontractors).
action_label(omit_direct_payment_to_subcontractors, 'Omit direct payment to subcontractors').
action_type(omit_terminate_contract_for_bndes_delay).
action_label(omit_terminate_contract_for_bndes_delay, 'Must not terminate if BNDES delays').
action_type(pay_indemnization_if_no_demand_total).
action_label(pay_indemnization_if_no_demand_total, 'Omit indemnization payment').
action_type(pay_taxes).
action_label(pay_taxes, 'Pay taxes').
action_type(present_confidentiality_terms).
action_label(present_confidentiality_terms, 'Present confidentiality terms').
action_type(present_cost_unit_spreadsheets).
action_label(present_cost_unit_spreadsheets, 'present cost unit spreadsheets').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(present_proof_bndes).
action_label(present_proof_bndes, 'Present proof to BNDES').
action_type(present_requested_information).
action_label(present_requested_information, 'present requested information').
action_type(prevent_administrators_from_corruption).
action_label(prevent_administrators_from_corruption, 'Prevent administrators from corruption').
action_type(prevent_favoritism).
action_label(prevent_favoritism, 'Prevent favoritism').
action_type(protect_fundamental_rights).
action_label(protect_fundamental_rights, 'Protect fundamental rights').
action_type(prove_exclusion_from_simples).
action_label(prove_exclusion_from_simples, 'Prove exclusion from Simples').
action_type(provide_data_access_channel).
action_label(provide_data_access_channel, 'Provide data access channel').
action_type(provide_documents_upon_request).
action_label(provide_documents_upon_request, 'Provide documents on request').
action_type(provide_fixed_line_telephone_service).
action_label(provide_fixed_line_telephone_service, 'Provide fixed line telephone service').
action_type(provide_information_for_service_execution).
action_label(provide_information_for_service_execution, 'Provide information').
action_type(provide_opportunity_to_defend).
action_label(provide_opportunity_to_defend, 'Provide opportunity to defend').
action_type(receive_fixed_line_telephone_service).
action_label(receive_fixed_line_telephone_service, 'Receive fixed line telephone service').
action_type(receive_indemnization_if_no_demand_total).
action_label(receive_indemnization_if_no_demand_total, 'No right to indemnization').
action_type(receive_object).
action_label(receive_object, 'Receive the object').
action_type(receive_object_through_gestor).
action_label(receive_object_through_gestor, 'Receive object through manager').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payment_for_execution).
action_label(receive_payment_for_execution, 'Receive payment for execution').
action_type(receive_payment_for_fixed_line_service).
action_label(receive_payment_for_fixed_line_service, 'Receive payment for fixed line service').
action_type(receive_payments_from_bndes).
action_label(receive_payments_from_bndes, 'Receive payments').
action_type(reduce_payment_due_to_partial_execution).
action_label(reduce_payment_due_to_partial_execution, 'Reduce payment').
action_type(reject_late_fiscal_document).
action_label(reject_late_fiscal_document, 'Reject late fiscal document').
action_type(remove_agents_with_impediments).
action_label(remove_agents_with_impediments, 'Remove agents with impediments').
action_type(repair_damages).
action_label(repair_damages, 'Repair damages').
action_type(repair_defects).
action_label(repair_defects, 'Repair defects').
action_type(report_impediments).
action_label(report_impediments, 'Report impediments').
action_type(request_data_impact_report).
action_label(request_data_impact_report, 'Request data impact report').
action_type(request_information_for_service_execution).
action_label(request_information_for_service_execution, 'Request Information').
action_type(request_price_readjustment).
action_label(request_price_readjustment, 'request price readjustment').
action_type(request_price_readjustment_or_revision_before_contract_end).
action_label(request_price_readjustment_or_revision_before_contract_end, 'request readjustment/revision before end').
action_type(request_price_revision).
action_label(request_price_revision, 'request price revision').
action_type(request_proof_of_qualification).
action_label(request_proof_of_qualification, 'Request proof of qualification').
action_type(request_reconsideration).
action_label(request_reconsideration, 'Request reconsideration').
action_type(request_reconsideration_action).
action_label(request_reconsideration_action, 'Right to Request reconsideration').
action_type(respect_economic_financial_equilibrium_clause).
action_label(respect_economic_financial_equilibrium_clause, 'Respect economic-financial equilibrium clause').
action_type(return_materials_to_bndes).
action_label(return_materials_to_bndes, 'Return materials to BNDES').
action_type(return_resources).
action_label(return_resources, 'Return resources').
action_type(right_of_recourse).
action_label(right_of_recourse, 'Right of recourse').
action_type(stipulate_service_standards).
action_label(stipulate_service_standards, 'Stipulate service standards').
action_type(store_data_securely).
action_label(store_data_securely, 'Store data securely').
action_type(subcontract_object).
action_label(subcontract_object, 'Subcontract object').
action_type(submit_contract_revision_request).
action_label(submit_contract_revision_request, 'submit contract revision request').
action_type(submit_dif).
action_label(submit_dif, 'Submit DIF').
action_type(succeed_contract).
action_label(succeed_contract, 'Succeed contract').
action_type(sujeitar_se_as_penalidades).
action_label(sujeitar_se_as_penalidades, 'Subject to penalties').
action_type(suspend_contract).
action_label(suspend_contract, 'Suspend contract').
action_type(terminate_contract_agreed_upon).
action_label(terminate_contract_agreed_upon, 'Terminate contract per agreement').
action_type(terminate_contract_for_breach).
action_label(terminate_contract_for_breach, 'Terminate for breach').
action_type(terminate_for_bndes_suspension).
action_label(terminate_for_bndes_suspension, 'Terminate for BNDES suspension').
action_type(terminate_for_cession_breach).
action_label(terminate_for_cession_breach, 'Terminate for breach of cession').
action_type(terminate_for_contractor_bankruptcy).
action_label(terminate_for_contractor_bankruptcy, 'Terminate for contractor bankruptcy').
action_type(terminate_for_corruption).
action_label(terminate_for_corruption, 'Terminate for corruption').
action_type(terminate_for_dishonesty_declaration).
action_label(terminate_for_dishonesty_declaration, 'Terminate for dishonesty declaration').
action_type(terminate_for_dissolution).
action_label(terminate_for_dissolution, 'Terminate for dissolution').
action_type(terminate_for_force_majeure).
action_label(terminate_for_force_majeure, 'Terminate for force majeure').
action_type(terminate_for_loss_of_qualification).
action_label(terminate_for_loss_of_qualification, 'Terminate for loss of qualification').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_0118_2022).
contract_metadata(contrato_ocs_0118_2022, numero_ocs, '0118/2022').
contract_metadata(contrato_ocs_0118_2022, numero_sap, '4400005040').
contract_metadata(contrato_ocs_0118_2022, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇOS').
contract_metadata(contrato_ocs_0118_2022, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'ALGAR TELECOM S/A']).
contract_metadata(contrato_ocs_0118_2022, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_0118_2022, contratado, 'ALGAR TELECOM S/A').
contract_metadata(contrato_ocs_0118_2022, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_0118_2022, cnpj_contratado, '71.208.516/0001-74').
contract_metadata(contrato_ocs_0118_2022, procedimento_licitatorio, 'Pregão Eletrônico nº 018/2022 - BNDES').
contract_metadata(contrato_ocs_0118_2022, data_autorizacao, '13/05/2022').
contract_metadata_raw(contrato_ocs_0118_2022, 'ip_ati_deset', '10/2022', 'trecho_literal').
contract_metadata(contrato_ocs_0118_2022, data_ip_ati_degat, '12/05/2022').
contract_metadata(contrato_ocs_0118_2022, rubrica_orcamentaria, '3101300003').
contract_metadata(contrato_ocs_0118_2022, centro_custo, 'BN00004000').
contract_metadata(contrato_ocs_0118_2022, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_0118_2022, regulamento, 'Regulamento Licitações e Contratos do Sistema BNDES').
contract_clause(contrato_ocs_0118_2022, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a prestação de serviço Telefônico Fixo Comutado (STFC), nas modalidades Local, Longa Distância Nacional (LDN) e Chamada Franqueada (0800), conforme especificações constantes das Especificações Técnicas (Anexo I do Edital do Pregão Eletrônico nº 018/2022 - BNDES) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_0118_2022, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 36 (tinta e seis) meses, a contar da data de sua assinatura, podendo ser prorrogado até o limite total de 60(sessenta) meses.   Parágrafo Primeiro O CONTRATADO deverá, no prazo de até 5 (cinco) dias úteis, contados da notificação do Gestor do Contrato, apresentar, por intermédio do seu Representante Legal, sua manifestação sobre a prorrogação do Contrato.  Parágrafo Segundo Independente da notificação do parágrafo anterior, o CONTRATADO deverá comunicar ao Gestor seu interesse quanto à prorrogação do contrato até 90 (noventa) dias antes do término de cada período de vigência contratual.  Parágrafo Terceiro A formalização da prorrogação será efetuada por meio de aditivo epistolar, dispensando-se a assinatura do CONTRATADO.  Parágrafo Quarto Caso o CONTRATADO se recuse a celebrar aditivo contratual de prorrogação, tendo antes manifestado sua intenção de prorrogar o Contrato ou deixado de manifestar seu propósito de não prorrogar, nos termos do Parágrafo Primeiro desta Cláusula, ficará sujeito às penalidades previstas na Cláusula de Penalidades deste Contrato.').
contract_clause(contrato_ocs_0118_2022, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes das Especificações Técnicas (Anexo I deste Contrato) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_0118_2022, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'Os serviços contratados deverão ser executados de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados pelo BNDES, observados os níveis de serviço descritos no Anexo I (Especificações Técnicas) deste Contrato.  Parágrafo Único O descumprimento dos níveis de serviço acarretará a aplicação dos índices de redução do preço previstos no Anexo I (Especificações Técnicas) deste Contrato, sem prejuízo da aplicação das penalidades previstas neste Contrato, quando cabíveis.').
contract_clause(contrato_ocs_0118_2022, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do Gestor mencionado na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo I (Especificações Técnicas) deste Contrato.').
contract_clause(contrato_ocs_0118_2022, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará ao CONTRATADO, pela execução do objeto contratado, o valor de até R$ 297.580,26 (duzentos e noventa e sete mil, quinhentos e oitenta reais e vinte e seis centavos), conforme proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento.  Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização ao CONTRATADO.   Parágrafo Quarto O CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato.').
contract_clause(contrato_ocs_0118_2022, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, mensalmente , por meio de crédito em conta bancária, em até 10 (dez) dias úteis, a contar da data de apresentação do documento fiscal ou equivalente legal (prioritariamente nota fiscal, e nos casos de dispensa da nota fiscal: fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Especificações Técnicas) deste Instrumento.  Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte da prestação do serviço/fornecimento do bem.   Parágrafo Segundo A apresentação do documento de cobrança fora do prazo previsto nesta cláusula poderá implicar em sua rejeição e no direito do BNDES se ressarcir, preferencialmente, mediante desconto do valor a ser pago ao CONTRATADO, por qualquer penalidade tributária incidente pelo atraso.  Parágrafo Terceiro Nas hipóteses em que o recebimento definitivo ocorrer após a entrega do documento fiscal ou equivalente legal, o BNDES terá até 10 (dez) dias úteis, a contar da data em que o objeto tiver sido recebido definitivamente, para efetuar o pagamento.  Parágrafo Quarto O primeiro documento fiscal ou equivalente legal terá como objeto de cobrança o período compreendido entre o dia de início da prestação dos serviços e o último dia desse mês, e os documentos fiscais ou equivalentes legais subsequentes terão como referência o período compreendido entre o primeiro e o último dia de cada mês. O último documento fiscal ou equivalente legal, por seu turno, referir-se-á ao período compreendido entre o primeiro dia do último mês da prestação dos serviços e o último dia de serviço prestado. Em todos os casos, o documento fiscal ou equivalente legal só poderá ser emitido e apresentado ao BNDES após a efetiva prestação do serviço, respeitado o disposto no Parágrafo anterior.  Parágrafo Quinto Para toda efetivação de pagamento, o Contratado deverá encaminhar o documento fiscal ou equivalente em meio digital para caixa postal eletrônica ou protocolar em sistema eletrônico próprio do BNDES, considerando as orientações do Contratante vigentes na ocasião do pagamento. No caso de emissão de documento fiscal exclusivamente em meio físico o mesmo deverá ser encaminhado ao protocolo do BNDES para devido registro de recebimento.  Parágrafo Sexto A sociedade líder do Consórcio poderá apresentar um documento fiscal ou equivalente legal para cada consorciado envolvido na execução contratual, proporcionalmente à respectiva parcela na execução do objeto quando permitido pela legislação tributária e desde que observadas as condições previstas nesta Cláusula.   Parágrafo Sétimo O BNDES não efetuará pagamento diretamente em favor do(s) Subcontratado(s).   Parágrafo Oitavo O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor do Contrato; V. descrição detalhada do objeto executado e dos respectivos valores; VI. período de referência da execução do objeto; VII. nome e número do CNPJ  do CONTRATADO, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VIII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; IX. nome e número do banco e da agência, bem como o número da conta corrente do CONTRATADO, vinculada ao CNPJ  constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; X. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; XI. CNPJ do tomador do serviço: 33.657.248/0001-89; XII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XIII. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento - DIF; e XIV.  destaque das retenções tributárias aplicáveis, conforme estabelecido na DIF.  Parágrafo Nono Os pagamentos a serem efetuados em favor do CONTRATADO estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pelo CONTRATADO. Em casos de dispensa ou benefício fiscal que implique em redução ou eliminação da retenção de tributos, o CONTRATADO fornecerá todos os documentos comprobatórios.  Parágrafo Décimo Caso o CONTRATADO emita documento fiscal ou equivalente legal autorizado por Município diferente daquele onde se localiza o estabelecimento do BNDES tomador do serviço e destinatário da cobrança, deverá providenciar o cadastro junto à Secretaria Municipal de Fazenda ou órgão equivalente do Município do estabelecimento tomador, salvo quando se aplicar uma das exceções constantes dos incisos do artigo 3º da Lei Complementar Federal nº 116/03. A inexistência desse cadastro ou o cadastro em item diverso do faturado não constitui impeditivo ao processo de pagamento, mas um ônus a ser suportado pelo CONTRATADO, uma vez que o BNDES está obrigado a reter na fonte a quantia equivalente ao ISS dos serviços faturados, conforme legislação aplicável.  Parágrafo Décimo Primeiro O documento fiscal ou equivalente legal emitido pelo CONTRATADO deverá estar em conformidade com a legislação do Município onde o CONTRATADO esteja estabelecido, cuja regularidade fiscal foi avaliada na fase de habilitação e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos, sob pena de devolução do documento e interrupção do prazo para pagamento.   Parágrafo Décimo Segundo Ao documento fiscal ou equivalente legal deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que o CONTRATADO é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; e IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado;  Parágrafo Décimo Terceiro Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal ao CONTRATADO ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Décimo Quarto Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pelo CONTRATADO.  Parágrafo Décimo Quinto Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível ao CONTRATADO, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.  Parágrafo Décimo Sexto Fica assegurado ao BNDES o direito de deduzir do pagamento devido ao CONTRATADO, por força deste Contrato ou de outro contrato mantido com o BNDES, o valor correspondente aos pagamentos efetuados a maior ou em duplicidade.').
contract_clause(contrato_ocs_0118_2022, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO O BNDES e o CONTRATADO têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pelo CONTRATADO a cada período mínimo de 12 (doze) meses, sendo o primeiro contado do dia 26/05/2022 data de apresentação da proposta (Anexo II deste Contrato) ou da data do último ato da ANATEL, conforme o caso, e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do Índice de Serviços de Telecomunicações – IST, divulgado pela ANATEL, acumulado no respectivo período, sobre o preço referido na Cláusula de Preço deste Instrumento, observando-se as demais disposições fixadas em ato da ANATEL porventura existente, na hipótese de o CONTRATADO prestar serviços sob o regime de concessão.  Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar o CONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.   Parágrafo Quarto O CONTRATADO deverá solicitar o reajuste e/ou a revisão de preços até a prorrogação ou o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias da prorrogação ou do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a assinatura do aditivo de prorrogação torne superveniente a ocorrência do fato gerador do reajuste, ou a divulgação do índice de reajuste ocorra após a prorrogação ou o encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso o CONTRATADO não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, não fará jus aos efeitos retroativos ou, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.  Parágrafo Quinto Se o processo de reajuste e/ou revisão de preços não for concluído até o vencimento do Contrato, e este for prorrogado, sua continuidade após o reequilíbrio econômico-financeiro ficará condicionada à manutenção da proposta do CONTRATADO como a condição mais vantajosa para o BNDES, podendo este: I. realizar negociação de preços junto ao CONTRATADO, de forma a viabilizar a continuidade do ajuste, quando os novos valores fixados após o reajuste e/ou a revisão de preços estiverem acima do patamar apurado no mercado; ou  II. rescindir o Contrato, mediante aviso prévio ao CONTRATADO, com antecedência de 30 (trinta) dias, quando resultar infrutífera a negociação indicada no inciso anterior.  Parágrafo Sexto Na ocorrência da hipótese prevista no inciso II do Parágrafo anterior, o CONTRATADO fará jus à integralidade dos valores apurados no processo de reajuste e/ou revisão de preços até o término do Contrato, não podendo, todavia, reclamar qualquer indenização em razão da rescisão do mesmo.', 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO O BNDES e o CONTRATADO têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pelo CONTRATADO a cada período mínimo de 12 (doze) meses, sendo o primeiro contado do dia 26/05/2022 data de apresentação da proposta (Anexo II deste Contrato) ou da data do último ato da ANATEL, conforme o caso, e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do Índice de Serviços de Telecomunicações – IST, divulgado pela ANATEL, acumulado no respectivo período, sobre o preço referido na Cláusula de Preço deste Instrumento, observando-se as demais disposições fixadas em ato da ANATEL porventura existente, na hipótese de o CONTRATADO prestar serviços sob o regime de concessão.  Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar o CONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.   Parágrafo Quarto O CONTRATADO deverá solicitar o reajuste e/ou a revisão de preços até a prorrogação ou o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias da prorrogação ou do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a assinatura do aditivo de prorrogação torne superveniente a ocorrência do fato gerador do reajuste, ou a divulgação do índice de reajuste ocorra após a prorrogação ou o encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso o CONTRATADO não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, não fará jus aos efeitos retroativos ou, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.  Parágrafo Quinto Se o processo de reajuste e/ou revisão de preços não for concluído até o vencimento do Contrato, e este for prorrogado, sua continuidade após o reequilíbrio econômico-financeiro ficará condicionada à manutenção da proposta do CONTRATADO como a condição mais vantajosa para o BNDES, podendo este: I. realizar negociação de preços junto ao CONTRATADO, de forma a viabilizar a continuidade do ajuste, quando os novos valores fixados após o reajuste e/ou a revisão de preços estiverem acima do patamar apurado no mercado; ou  II. rescindir o Contrato, mediante aviso prévio ao CONTRATADO, com antecedência de 30 (trinta) dias, quando resultar infrutífera a negociação indicada no inciso anterior.  Parágrafo Sexto Na ocorrência da hipótese prevista no inciso II do Parágrafo anterior, o CONTRATADO fará jus à integralidade dos valores apurados no processo de reajuste e/ou revisão de preços até o término do Contrato, não podendo, todavia, reclamar qualquer indenização em razão da rescisão do mesmo.').
contract_clause(contrato_ocs_0118_2022, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.   Parágrafo Primeiro O reajuste de preço aludido na Matriz de Riscos deve respeitar o disposto na
contract_clause(contrato_ocs_0118_2022, clausula_decima_obrigacoes_contratado, 'CLÁUSULA DÉCIMA – OBRIGAÇÕES DO CONTRATADO Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação e a ausência de impedimentos exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição a si de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que seja emitido em desacordo com a legislação aplicável; VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; XI. apresentar, em até 10 (dez) dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; b) no caso de consórcio, o CONTRATADO deverá apresentar, ainda, uma DIF para cada consorciado, devidamente preenchida(s) com os respectivos dados e assinada(s) pelo(s) respectivo(s) representante(s) legal(is). XII. atender às solicitações do BNDES relativas à transição contratual entre o CONTRATADO e o seu sucessor na execução dos serviços, prestando todo o suporte, inclusive a capacitação dos profissionais de seu sucessor, a fim de que o objeto contratado não seja interrompido;  XIII. responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos serviços, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES; XIV. devolver recursos disponibilizados pelo BNDES, revogar perfis de acesso de seus profissionais, eliminar suas caixas postais e adotar demais providências aplicáveis ao término da vigência deste Contrato;', 'CLÁUSULA DÉCIMA – OBRIGAÇÕES DO CONTRATADO Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação e a ausência de impedimentos exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição a si de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que seja emitido em desacordo com a legislação aplicável; VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; XI. apresentar, em até 10 (dez) dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; b) no caso de consórcio, o CONTRATADO deverá apresentar, ainda, uma DIF para cada consorciado, devidamente preenchida(s) com os respectivos dados e assinada(s) pelo(s) respectivo(s) representante(s) legal(is). XII. atender às solicitações do BNDES relativas à transição contratual entre o CONTRATADO e o seu sucessor na execução dos serviços, prestando todo o suporte, inclusive a capacitação dos profissionais de seu sucessor, a fim de que o objeto contratado não seja interrompido;  XIII. responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos serviços, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES; XIV. devolver recursos disponibilizados pelo BNDES, revogar perfis de acesso de seus profissionais, eliminar suas caixas postais e adotar demais providências aplicáveis ao término da vigência deste Contrato;').
contract_clause(contrato_ocs_0118_2022, clausula_decima_primeira_conduta_etica, 'CLÁUSULA DÉCIMA PRIMEIRA – CONDUTA ÉTICA DO CONTRATADO E DO BNDES', 'O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar a Política para Transações com Partes Relacionadas e o Código de Ética do Sistema BNDES vigentes ao tempo da contratação, bem como a Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_0118_2022, clausula_decima_segunda_sigilo, 'CLÁUSULA DÉCIMA SEGUNDA – SIGILO DAS INFORMAÇÕES', 'Cabe ao CONTRATADO cumprir as seguintes regras de sigilo e assegurar a aceitação e adesão às mesmas por profissionais que integrem ou venham a integrar a sua equipe na prestação do objeto deste Contrato, as quais perdurarão, inclusive, após a cessação do vínculo contratual e da prestação dos serviços: I. cumprir as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES, necessárias para assegurar a integridade e o sigilo das informações;  II. não acessar informações sigilosas do BNDES, salvo quando previamente autorizado por escrito; III. sempre que tiver acesso às informações mencionadas no inciso anterior: a) manter sigilo dessas informações, não podendo copiá-las, reproduzi-las, retê-las ou praticar qualquer outra forma de uso que não seja imprescindível para a adequada prestação do objeto deste Contrato; b) limitar o acesso às informações aos profissionais envolvidos na prestação dos serviços objeto deste Contrato, os quais deverão estar cientes da natureza sigilosa das informações e das obrigações e responsabilidades decorrentes do uso dessas informações; e c) informar imediatamente ao BNDES qualquer violação das regras de sigilo ora estabelecidas que tenha ocorrido por sua ação ou omissão, independentemente da existência de dolo, bem como dos profissionais envolvidos, adotando todas as orientações do BNDES para remediar a violação; IV. entregar ao BNDES, ao término da vigência deste Contrato, todo e qualquer material de propriedade deste, inclusive notas pessoais envolvendo matéria sigilosa e registro de documentos de qualquer natureza que tenham sido criados, usados ou mantidos sob seu controle ou posse, assumindo o compromisso de não utilizar qualquer informação sigilosa a que teve acesso no âmbito deste Contrato;  V. apresentar, antes do início da prestação dos serviços, Termos de Confidencialidade, conforme minuta constante do Anexo V (Minuta de Termo de Confidencialidade para Profissionais) deste Contrato, assinados pelos profissionais que acessarão informações sigilosas, devendo referida obrigação ser também cumprida por ocasião de substituição desses profissionais; e VI. observar o disposto no Termo de Confidencialidade assinado por seu Representante Legal constante do Anexo IV (Termo de Confidencialidade para Representante Legal) deste Contrato.').
contract_clause(contrato_ocs_0118_2022, clausula_decima_terceira_acesso_e_protecao_de_dados_pessoais, 'CLÁUSULA DÉCIMA TERCEIRA – ACESSO E PROTEÇÃO DE DADOS PESSOAIS', 'As partes assumem o compromisso de proteger os direitos fundamentais de liberdade e de privacidade, relativos ao tratamento de dados pessoais, nos meios físicos e digitais, devendo, para tanto, adotar medidas corretas de segurança sob o aspecto técnico, jurídico e administrativo, e observar que:    I. Eventual tratamento de dados em razão do presente Contrato deverá ser realizado conforme os parâmetros previstos na legislação, especialmente na Lei n° 13.709/2018 – Lei Geral de Proteção de Dados - LGPD, dentro de propósitos legítimos, específicos, explícitos e informados ao titular;   II. O tratamento será limitado às atividades necessárias ao atingimento das finalidades contratuais e, caso seja necessário, ao cumprimento de suas obrigações legais ou regulatórias, sejam de ordem principal ou acessória, observando-se que, em caso de necessidade de coleta de dados pessoais, esta será realizada mediante prévia aprovação do BNDES, responsabilizando-se o CONTRATADO por obter o consentimento dos titulares, salvo nos casos em que a legislação dispense tal medida;  III. O CONTRATADO deverá seguir as instruções recebidas do BNDES em relação ao tratamento de dados pessoais;  IV. O CONTRATADO se responsabilizará como “Controlador de dados” no caso do tratamento de dados para o cumprimento de suas obrigações legais ou regulatórias, devendo obedecer aos parâmetros previstos na legislação;  V. Os dados coletados somente poderão ser utilizados pelas partes, seus representantes, empregados e prestadores de serviços diretamente alocados na execução contratual, sendo que, em hipótese alguma, poderão ser compartilhados ou utilizados para outros fins, sem a prévia autorização do BNDES, ou caso haja alguma ordem judicial, observando-se as medidas legalmente previstas para tanto;  VI. O CONTRATADO deve manter a confidencialidade dos dados pessoais obtidos em razão do presente contrato, devendo adotar as medidas técnicas e administrativas adequadas e necessárias, visando assegurar a proteção dos dados, nos termos do artigo 46 da LGPD, de modo a garantir um nível apropriado de segurança e a prevenção e mitigação de eventuais riscos;  VII. Os dados deverão ser armazenados de maneira segura pelo CONTRATADO, que utilizará recursos de segurança da informação e tecnologia adequados, inclusive quanto a mecanismos de detecção e prevenção de ataques cibernéticos e incidentes de segurança da informação.   VIII. O CONTRATADO dará conhecimento formal para seus empregados e/ou prestadores de serviço acerca das disposições previstas nesta Cláusula e na Cláusula de Sigilo das Informações, responsabilizando-se por eventual uso indevido dos dados pessoais, bem como por quaisquer falhas nos sistemas por ela empregados para o tratamento dos dados.  IX. O BNDES possui direito de regresso em face do CONTRATADO em razão de eventuais danos causados por este em decorrência do descumprimento das responsabilidades e obrigações previstas no âmbito deste contrato e da Lei Geral de Proteção de Dados Pessoais;  X. O CONTRATADO deverá disponibilizar ao titular do dado um canal ou sistema em que seja garantida consulta facilitada e gratuita sobre a forma, a duração do tratamento e a integralidade de seus dados pessoais.  XI. O CONTRATADO deverá informar imediatamente ao BNDES todas as solicitações recebidas em razão do exercício dos direitos pelo titular dos dados relacionados a este Contrato, seguindo as orientações fixadas pelo BNDES e pela legislação em vigor para o adequado endereçamento das demandas.  XII. O CONTRATADO deverá manter registro de todas as operações de tratamento de dados pessoais que realizar no âmbito do Contrato disponibilizando, sempre que solicitado pelo BNDES, as informações necessárias à produção do Relatório de Impacto de Dados Pessoais, disposto no artigo 5º, XVII, da Lei Geral de Proteção de Dados Pessoais.  XIII. Qualquer incidente que implique em violação ou risco de violação ou vazamento de dados pessoais deverá ser prontamente comunicado ao BNDES, informando-se também todas as providências adotadas e os dados pessoais eventualmente afetados, cabendo ao CONTRATADO disponibilizar as informações e documentos solicitados e colaborar com qualquer investigação ou auditoria que venha a ser realizada.  XIV. Ao final da vigência do Contrato, o CONTRATADO deverá eliminar de sua base de informações todo e qualquer dado pessoal que tenha tido acesso em razão da execução do objeto contratado, salvo quando tenha que manter a informação para o cumprimento de obrigação legal.  Parágrafo Primeiro  As Partes reconhecem que, se durante a execução do Contrato armazenarem, coletarem, tratarem ou de qualquer outra forma processarem dados pessoais, no sentido dado pela legislação vigente aplicável, o BNDES será considerado “Controlador de Dados”, e o CONTRATADO “Operador” ou “Processador de Dados”, salvo nas situações expressas em contrário nesse Contrato. Contudo, caso o CONTRATADO descumpra as obrigações prevista na legislação de proteção de dados ou as instruções do BNDES, será equiparado a “Controlador de Dados”, inclusive para fins de sua responsabilização por eventuais danos causados.  Parágrafo Segundo Caso o CONTRATADO disponibilize dados de terceiros, além das obrigações no caput desta Cláusula, deve se responsabilizar por eventuais danos que o BNDES venha a sofrer em decorrência de uso indevido de dados pessoais por parte do CONTRATADO, sempre que ficar comprovado que houve falha de segurança técnica e administrativa, descumprimento de regras previstas na legislação de proteção à privacidade e dados pessoais, e das orientações do BNDES, sem prejuízo das penalidades deste contrato.  Parágrafo Terceiro A transferência internacional de dados deve se dar em caráter excepcional e na estrita observância da legislação, especialmente, dos artigos 33 a 36 da Lei n° 13.709/2018 e nos normativos do Banco Central do Brasil relativos ao processamento e armazenamento de dados das instituições financeiras, e dependerá de autorização prévia do BNDES ao CONTRATADO.   Parágrafo Quarto A assinatura deste Contrato importa na manifestação de inequívoco consentimento do titular, seja ele pessoa física direta ou indiretamente relacionada ao CONTRATADO, inclusive sócios, representantes legais, empregados, contratados e/ou terceirizados, quando for o caso, dos dados pessoais que tenham se tornados públicos como condição para participação na licitação e para contratação, para tratamento pelo BNDES, na forma da Lei nº 13.709/2018. Poderão ser solicitados pelo BNDES dados pessoais adicionais a fim de viabilizar o cumprimento de obrigação legal.  Parágrafo Quinto Os representantes legais signatários do presente autorizam a divulgação dos dados pessoais expressamente contidos nos documentos decorrentes do procedimento de licitação, tais como nome, CPF, e-mail, telefone e cargo, para fins de publicidade das contratações administrativas no site institucional do BNDES e em cumprimento à Lei nº 12.527/ 2011 (Lei de Acesso à Informação).  Parágrafo Sexto As partes comprometem-se a coletar o consentimento, quando necessário, conforme previsto na Lei no 13.709/2018 (Lei Geral de Proteção de Dados - LGPD), bem como informar os titulares dos dados pessoais mencionados no presente instrumento, para as finalidades descritas no parágrafo acima.').
contract_clause(contrato_ocs_0118_2022, clausula_decima_quarta_obrigacoes_do_bndes, 'CLÁUSULA DÉCIMA QUARTA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos ao CONTRATADO, nas condições estabelecidas neste Contrato;  II. designar, como Gestor do Contrato, Fernanda Pereira Goulart, que atualmente exerce a função de Coordenadora de Serviço, ou seu substituto, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução dos serviços, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita ao CONTRATADO; IV. fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, cópia do Código de Ética do Sistema BNDES, da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; V. colocar à disposição do CONTRATADO todas as informações necessárias à perfeita execução dos serviços objeto deste Contrato; e VI. comunicar ao CONTRATADO, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares do CONTRATADO, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_0118_2022, clausula_decima_quinta_equidade_de_genero_e_valorizacao_da_diversidade, 'CLÁUSULA DÉCIMA QUINTA – EQUIDADE DE GÊNERO E VALORIZAÇÃO DA DIVERSIDADE', 'O CONTRATADO deverá comprovar, sempre que solicitado pelo BNDES, a inexistência de decisão administrativa final sancionadora, exarada por autoridade ou órgão competente, em razão da prática de atos, pelo próprio CONTRATADO ou dirigentes, administradores ou sócios majoritários, que importem em discriminação de raça ou gênero, trabalho infantil ou trabalho escravo, e de sentença condenatória transitada em julgado, proferida em decorrência dos referidos atos, e, se for o caso, de outros que caracterizem assédio moral ou sexual e importem em crime contra o meio ambiente.   Parágrafo Primeiro Na hipótese de ter havido decisão administrativa e/ou sentença condenatória, nos termos referidos no caput desta Cláusula, a execução do objeto contratual poderá ser suspensa pelo BNDES até a comprovação do cumprimento da reparação imposta ou da reabilitação do CONTRATADO ou de seus dirigentes, conforme o caso.  Parágrafo Segundo A comprovação a que se refere o caput desta Cláusula será realizada por meio de declaração, sem prejuízo da verificação do sistema informativo interno do BNDES – Sistema de Gerenciamento do Cadastro de Entidades (N02), acerca da inexistência de sanção em face do CONTRATADO e/ou de seus dirigentes, administradores ou sócios majoritários que impeça a contratação.')
contract_clause(contrato_ocs_0118_2022, clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, 'CLÁUSULA DÉCIMA SEXTA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO  É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro É admitida a sucessão contratual nas hipóteses em que o CONTRATADO realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo, por conseguinte, jus ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É admitida a subcontratação da parcela do objeto deste Contrato, conforme previsto nas Especificações Técnicas, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal operação; e II. atendimento de todas as condições contratuais e requisitos para a subcontratação previstos no Edital e nas Especificações Técnicas (Anexo I deste Contrato), cabendo ao CONTRATADO apresentar, sempre que solicitado pelo BNDES, os respectivos documentos comprobatórios.  Parágrafo Quarto A subcontratação pode ser realizada com sociedades distintas e de forma simultânea, devendo, em todos os casos, ser relacionada à parcela do objeto autorizada pelo BNDES.  Parágrafo Quinto Caso o CONTRATADO opte por subcontratar o objeto deste Contrato, permanecerá como responsável perante o BNDES pela adequada execução do ajuste, sujeitando-se, inclusive, às penalidades previstas neste Contrato, na hipótese de não cumprir as obrigações ora pactuadas, ainda que por culpa da sociedade subcontratada.  Parágrafo Sexto Aceita, pelo BNDES, a subcontratação, o CONTRATADO deverá apresentar os Termos de Confidencialidade, conforme minuta constante do Anexo VI (Minuta de Termo de Confidencialidade para Subcontratação) deste Contrato, assinados pelo representante legal e pelos profissionais da sociedade subcontratada envolvidos na execução dos serviços subcontratados.', 'trecho_literal').
contract_clause(contrato_ocs_0118_2022, clausula_decima_setima_penalidades, 'CLÁUSULA DÉCIMA SÉTIMA – PENALIDADES Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: I. advertência; II. multa, de acordo com o Anexo I (Especificações Técnicas); e III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.    Parágrafo Primeiro As penalidades serão aplicadas observadas as normas do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Segundo  Contra a decisão de aplicação de penalidade, o CONTRATADO poderá requerer a reconsideração para a decisão de advertência, ou interpor o recurso cabível para as demais penalidades, na forma e no prazo previstos no Regulamento de Licitações e Contratos do SISTEMA BNDES.  Parágrafo Terceiro  A imposição de penalidade prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto  A multa poderá ser aplicada juntamente com as demais penalidades.  Parágrafo Quinto  A multa aplicada ao CONTRATADO e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ele devidos, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto  No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Sétimo A celebração de Termo de Ajustamento de Conduta prevista no Regulamento de Licitações e Contratos do Sistema BNDES não importa em renúncia às penalidades prevista neste Contrato e no Anexo I (Especificações Técnicas).  Parágrafo Oitavo A sanção prevista no inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.', 'trecho_literal').
contract_clause(contrato_ocs_0118_2022, clausula_decima_oitava_alteracoes_contratuais, 'CLÁUSULA DÉCIMA OITAVA – ALTERAÇÕES CONTRATUAIS  O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:  I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas nas Especificações Técnicas (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo       A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.     Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento, os ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato e alterações de preços decorrentes decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, que poderão ser celebrados por meio epistolar.', 'trecho_literal').
contract_clause(contrato_ocs_0118_2022, clausula_decima_nona_extincao_contrato, 'CLÁUSULA DÉCIMA NONA – EXTINÇÃO DO CONTRATO O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, e ainda: I. Consensualmente, formalizada em autorização escrita e fundamentada do BNDES, mediante aviso prévio por escrito, com antecedência mínima de 90 (noventa) dias ou de prazo menor a ser negociado pelas partes à época da rescisão; II. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; III. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; IV. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo;  V. quando for decretada a falência do CONTRATADO; VI. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VII. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VIII. caso o CONTRATADO seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  IX. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; X. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; XI. em razão da dissolução do CONTRATADO;  XII. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato; e  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.', 'trecho_literal').
contract_clause(contrato_ocs_0118_2022, clausula_vigésima_disposicoes_finais, 'CLÁUSULA VIGÉSIMA – DISPOSIÇÕES FINAIS Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram o presente Contrato: Anexo I - Especificações Técnicas Anexo II - Proposta Anexo III - Matriz de Riscos Anexo IV - Termo de Confidencialidade para Representante Legal Anexo V - Minuta de Termo de Confidencialidade para Profissionais Anexo VI - Minuta de Termo de Confidencialidade para Subcontratação  Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.', 'trecho_literal').
contract_clause(contrato_ocs_0118_2022, clausula_vigésima_primeira_foro, 'CLÁUSULA VIGÉSIMA PRIMEIRA – FORO  É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As folhas deste contrato foram conferidas por Necesio Antonio Krapp Tavares, advogado do BNDES, por autorização do representante legal que o assina.  As partes consideram, para todos os efeitos, a data da última assinatura digital como a da formalização jurídica deste instrumento.  E, por estarem assim justos e contratados, firmam o presente Instrumento, juntamente com as testemunhas abaixo.      _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES     _____________________________________________________________________ ALGAR TELECOM S/A      Testemunhas:   _________________________________ _________________________________ Nome/CPF:                                                Nome/CPF:                                                                      Assinado de forma digital por JEANKARLO RODRIGUES DA CUNHA:04739992698LUISA DE GOIS AQUINO:98647083687Assinado de forma digital por LUISA DE GOIS AQUINO:98647083687DIOGO MORENO PEREIRA GOMES:09278449741Assinado de forma digital por DIOGO MORENO PEREIRA GOMES:09278449741 Dados: 2022.06.24 10:51:28 -03\'00\'FERNANDO PASSERI LAVRADO:00486757765Assinado de forma digital por FERNANDO PASSERI LAVRADO:00486757765 Dados: 2022.06.24 11:09:30 -03\'00\'Assinado Digitalmente Por Felipe Mello Dados: 2022.06.24 11:23:21 -03\'00\'Assinado digitalmente  por Leonardo de Barros C. Neves 2022.06.24 11:25:29 -03\'00\'', 'trecho_literal').

% ===== END =====
