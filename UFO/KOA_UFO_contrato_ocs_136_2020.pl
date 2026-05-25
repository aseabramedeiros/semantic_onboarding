% ===== KOA Combined Output | contract_id: contrato_ocs_136_2020 =====

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
% UFO-only grounding generated from: KOA_Contrato_OCS_136_2020_-_Zoom_Tecnologia_(Service_Desk).pl
% contract_id: contrato_ocs_136_2020

instance_of(contrato_ocs_136_2020, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(zoom_tecnologia_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_136_2020).
plays_role(zoom_tecnologia_ltda, hired_service_provider_role, contrato_ocs_136_2020).

clause_of(clausula_primeira_objeto, contrato_ocs_136_2020).
clause_of(clausula_segunda_vigencia, contrato_ocs_136_2020).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_136_2020).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_136_2020).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_136_2020).
clause_of(clausula_sexta_preco, contrato_ocs_136_2020).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_136_2020).
clause_of(clausula_decima_garantia_contratual, contrato_ocs_136_2020).
clause_of(clausula_decima_terceira_conduta_etica, contrato_ocs_136_2020).
clause_of(clausula_decima_quarta_sigilo, contrato_ocs_136_2020).
clause_of(clausula_decima_quinta_obrigacoes_bndes, contrato_ocs_136_2020).
clause_of(clausula_decima_sexta_cessao, contrato_ocs_136_2020).
clause_of(clausula_decima_setima_penalidades, contrato_ocs_136_2020).
clause_of(clausula_decima_oitava_alteracoes_contratuais, contrato_ocs_136_2020).
clause_of(clausula_decima_nona_extincao_contrato, contrato_ocs_136_2020).
clause_of(clausula_vigésima_disposicoes_finais, contrato_ocs_136_2020).
clause_of(clausula_vigésima_primeira_foro, contrato_ocs_136_2020).
clause_of(clausula_setima_pagamento, contrato_ocs_136_2020).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_136_2020).
clause_of(clausula_decima_primeira_obrigações_contratado, contrato_ocs_136_2020).
clause_of(clausula_decima_segunda_obrigações_trabalhistas_e_previdenciárias_do_contratado, contrato_ocs_136_2020).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, zoom_tecnologia_ltda, provide_technical_services).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_technical_support).
legal_relation_instance(clausula_primeira_objeto, right_to_action, zoom_tecnologia_ltda, receive_payment_for_technical_services).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, zoom_tecnologia_ltda, communicate_non_renewal).
legal_relation_instance(clausula_segunda_vigencia, subjection, zoom_tecnologia_ltda, subject_to_penalties).
legal_relation_instance(clausula_segunda_vigencia, right_to_omission, zoom_tecnologia_ltda, omit_communicate_non_renewal).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, zoom_tecnologia_ltda, accept_contract_renewal).
legal_relation_instance(clausula_segunda_vigencia, right_to_omission, zoom_tecnologia_ltda, omit_accept_contract_renewal).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, convene_contracted_for_alignment_meeting).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, convene_contracted_for_alignment_meeting).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, zoom_tecnologia_ltda, attend_alignment_meeting).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, zoom_tecnologia_ltda, maintain_qualified_personnel_registry).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, zoom_tecnologia_ltda, perform_personnel_substitution_within_bndes_timeframe).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, zoom_tecnologia_ltda, ensure_substitute_meets_requirements).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, zoom_tecnologia_ltda, submit_substitution_request).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, approve_personnel_substitution).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, permission_to_act, zoom_tecnologia_ltda, substitute_personnel).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, zoom_tecnologia_ltda, execute_services_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_price_reduction_indexes).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, zoom_tecnologia_ltda, be_subject_to_price_reduction_indexes).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, enforce_service_level_agreements).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_object).
legal_relation_instance(clausula_quinta_recebimento_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_object).
legal_relation_instance(clausula_sexta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_party).
legal_relation_instance(clausula_sexta_preco, right_to_action, zoom_tecnologia_ltda, receive_payment).
legal_relation_instance(clausula_sexta_preco, duty_to_act, zoom_tecnologia_ltda, bear_costs_of_quantity_errors).
legal_relation_instance(clausula_sexta_preco, no_right_to_action, zoom_tecnologia_ltda, no_right_to_indemnification).
legal_relation_instance(clausula_sexta_preco, subjection, zoom_tecnologia_ltda, subject_to_reduced_payments).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, zoom_tecnologia_ltda, request_price_repactuation).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, review_prices).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_repactuation_revision_request).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, zoom_tecnologia_ltda, present_cost_information).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_omit, zoom_tecnologia_ltda, not_include_unforeseen_benefits).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, zoom_tecnologia_ltda, receive_retroactive_effects).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, zoom_tecnologia_ltda, provide_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, zoom_tecnologia_ltda, complement_or_replace_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, zoom_tecnologia_ltda, obtain_guarantor_consent).
legal_relation_instance(clausula_decima_garantia_contratual, subjection, zoom_tecnologia_ltda, penalty_for_failure_to_provide_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_provision_of_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extend_deadline_for_guarantee).
legal_relation_instance(clausula_decima_terceira_conduta_etica, duty_to_act, zoom_tecnologia_ltda, prevent_undue_advantage).
legal_relation_instance(clausula_decima_terceira_conduta_etica, duty_to_omit, zoom_tecnologia_ltda, not_offer_advantage).
legal_relation_instance(clausula_decima_terceira_conduta_etica, duty_to_omit, zoom_tecnologia_ltda, prevent_favoritism).
legal_relation_instance(clausula_decima_terceira_conduta_etica, duty_to_omit, zoom_tecnologia_ltda, not_allocate_relatives).
legal_relation_instance(clausula_decima_terceira_conduta_etica, duty_to_act, zoom_tecnologia_ltda, observe_code_of_ethics).
legal_relation_instance(clausula_decima_terceira_conduta_etica, duty_to_act, zoom_tecnologia_ltda, remove_impeded_agents).
legal_relation_instance(clausula_decima_terceira_conduta_etica, duty_to_act, zoom_tecnologia_ltda, adopt_sustainable_practices).
legal_relation_instance(clausula_decima_terceira_conduta_etica, duty_to_act, zoom_tecnologia_ltda, report_impediments).
legal_relation_instance(clausula_decima_quarta_sigilo, duty_to_act, zoom_tecnologia_ltda, comply_with_bndes_information_security_policy).
legal_relation_instance(clausula_decima_quarta_sigilo, duty_to_omit, zoom_tecnologia_ltda, not_access_confidential_bndes_information).
legal_relation_instance(clausula_decima_quarta_sigilo, duty_to_act, zoom_tecnologia_ltda, maintain_information_secrecy).
legal_relation_instance(clausula_decima_quarta_sigilo, duty_to_omit, zoom_tecnologia_ltda, not_copy_reproduce_or_retain).
legal_relation_instance(clausula_decima_quarta_sigilo, duty_to_act, zoom_tecnologia_ltda, limit_access_to_involved_professionals).
legal_relation_instance(clausula_decima_quarta_sigilo, duty_to_act, zoom_tecnologia_ltda, inform_bndes_of_violation).
legal_relation_instance(clausula_decima_quarta_sigilo, duty_to_act, zoom_tecnologia_ltda, deliver_materials_to_bndes).
legal_relation_instance(clausula_decima_quarta_sigilo, duty_to_omit, zoom_tecnologia_ltda, not_use_confidential_info_after_termination).
legal_relation_instance(clausula_decima_quarta_sigilo, duty_to_act, zoom_tecnologia_ltda, present_confidentiality_terms).
legal_relation_instance(clausula_decima_quarta_sigilo, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, authorize_access_to_confidential_information).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments_to_contracted).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_contracted_of_manager_change).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_receiving_committee).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_ethics_code_copy).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_available_necessary_information).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions_to_contracted).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_contracted_of_investigation).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_contracted_of_penalty).
legal_relation_instance(clausula_decima_sexta_cessao, duty_to_omit, zoom_tecnologia_ltda, omit_contract_cession).
legal_relation_instance(clausula_decima_sexta_cessao, no_right_to_action, zoom_tecnologia_ltda, no_right_to_cede_contract).
legal_relation_instance(clausula_decima_sexta_cessao, duty_to_omit, zoom_tecnologia_ltda, omit_credit_cession).
legal_relation_instance(clausula_decima_sexta_cessao, no_right_to_action, zoom_tecnologia_ltda, no_right_to_cede_credit).
legal_relation_instance(clausula_decima_sexta_cessao, duty_to_omit, zoom_tecnologia_ltda, omit_issue_credit_title).
legal_relation_instance(clausula_decima_sexta_cessao, no_right_to_action, zoom_tecnologia_ltda, no_right_to_issue_credit_title).
legal_relation_instance(clausula_decima_sexta_cessao, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_risks_of_corporate_operations).
legal_relation_instance(clausula_decima_sexta_cessao, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, consent_corporate_operations).
legal_relation_instance(clausula_decima_sexta_cessao, subjection, zoom_tecnologia_ltda, must_obtain_bndes_consent_for_succession).
legal_relation_instance(clausula_decima_sexta_cessao, duty_to_act, zoom_tecnologia_ltda, maintain_contractual_conditions_in_succession).
legal_relation_instance(clausula_decima_setima_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_setima_penalidades, subjection, zoom_tecnologia_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_decima_setima_penalidades, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_setima_penalidades, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_multas_from_credit).
legal_relation_instance(clausula_decima_setima_penalidades, duty_to_act, zoom_tecnologia_ltda, comply_with_bndes_requirements).
legal_relation_instance(clausula_decima_setima_penalidades, duty_to_act, zoom_tecnologia_ltda, observe_data_protection_law).
legal_relation_instance(clausula_decima_setima_penalidades, duty_to_act, zoom_tecnologia_ltda, observe_anti_corruption_law).
legal_relation_instance(clausula_decima_oitava_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, compensate_damages_from_refusal).
legal_relation_instance(clausula_decima_oitava_alteracoes_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, bear_liability_for_unjustified_refusal).
legal_relation_instance(clausula_decima_oitava_alteracoes_contratuais, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alter_contract).
legal_relation_instance(clausula_decima_oitava_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_alteration).
legal_relation_instance(clausula_decima_oitava_alteracoes_contratuais, right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, refuse_contract_alteration).
legal_relation_instance(clausula_decima_nona_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_written_notice).
legal_relation_instance(clausula_decima_nona_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_opportunity_to_defend).
legal_relation_instance(clausula_decima_nona_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_nona_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, right_to_terminate_contract).
legal_relation_instance(clausula_vigésima_disposicoes_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights).
legal_relation_instance(clausula_vigésima_disposicoes_finais, no_right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, must_demand_compliance).
legal_relation_instance(clausula_vigésima_disposicoes_finais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_compliance).
legal_relation_instance(clausula_vigésima_disposicoes_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, claim_under_contract).
legal_relation_instance(clausula_vigésima_primeira_foro, power, unknown, establish_forum_rio_de_janeiro).
legal_relation_instance(clausula_vigésima_primeira_foro, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, bring_action_outside_rio).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, zoom_tecnologia_ltda, present_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_values).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, credit_account).
legal_relation_instance(clausula_setima_pagamento, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_values_power).
legal_relation_instance(clausula_setima_pagamento, subjection, zoom_tecnologia_ltda, subject_to_deductions).
legal_relation_instance(clausula_nona_matriz_riscos, no_right_to_action, zoom_tecnologia_ltda, request_additives_for_allocated_events).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, zoom_tecnologia_ltda, respect_economic_financial_equilibrium).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, zoom_tecnologia_ltda, maintain_qualification_conditions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, zoom_tecnologia_ltda, communicate_penalty).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, zoom_tecnologia_ltda, repair_correct_remove_reconstruct_or_replace).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, zoom_tecnologia_ltda, repair_damages_bndes_third_parties).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, zoom_tecnologia_ltda, pay_taxes_charges).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, zoom_tecnologia_ltda, provide_to_rfb).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, zoom_tecnologia_ltda, designate_representative).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, zoom_tecnologia_ltda, guarantee_contract_object_not_infringe_rights).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, zoom_tecnologia_ltda, comply_with_security_standards).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, zoom_tecnologia_ltda, return_resources).
legal_relation_instance(clausula_decima_segunda_obrigações_trabalhistas_e_previdenciárias_do_contratado, duty_to_act, zoom_tecnologia_ltda, comply_with_labor_obligations).
legal_relation_instance(clausula_decima_segunda_obrigações_trabalhistas_e_previdenciárias_do_contratado, duty_to_act, zoom_tecnologia_ltda, comply_with_social_security_obligations).

% --- Action catalog (local to this contract grounding) ---
action_type(accept_contract_renewal).
action_label(accept_contract_renewal, 'Accept contract renewal').
action_type(access_signed_terms_documents_information).
action_label(access_signed_terms_documents_information, 'Access to signed terms, documents and information').
action_type(adopt_sustainable_practices).
action_label(adopt_sustainable_practices, 'Adopt sustainable practices').
action_type(alter_contract).
action_label(alter_contract, 'Alter contract').
action_type(analyze_repactuation_revision_request).
action_label(analyze_repactuation_revision_request, 'Analyze repactuation/revision request').
action_type(analyze_risks_of_corporate_operations).
action_label(analyze_risks_of_corporate_operations, 'Analyze risks of corporate operations').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_price_reduction_indexes).
action_label(apply_price_reduction_indexes, 'Apply price reduction indexes').
action_type(approve_personnel_substitution).
action_label(approve_personnel_substitution, 'Approve personnel substitution').
action_type(attend_alignment_meeting).
action_label(attend_alignment_meeting, 'Attend alignment meeting').
action_type(attend_transition_requests).
action_label(attend_transition_requests, 'Attend transition requests').
action_type(authorize_access_to_confidential_information).
action_label(authorize_access_to_confidential_information, 'Authorize access to info').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Subject to penalties').
action_type(be_subject_to_price_reduction_indexes).
action_label(be_subject_to_price_reduction_indexes, 'Subject to price reduction indexes').
action_type(bear_costs_of_quantity_errors).
action_label(bear_costs_of_quantity_errors, 'Bear costs of quantity errors').
action_type(bear_liability_for_unjustified_refusal).
action_label(bear_liability_for_unjustified_refusal, 'Liability for refusal').
action_type(bring_action_outside_rio).
action_label(bring_action_outside_rio, 'No right to bring action outside Rio').
action_type(claim_under_contract).
action_label(claim_under_contract, 'Claim under contract').
action_type(communicate_instructions_to_contracted).
action_label(communicate_instructions_to_contracted, 'Communicate instructions').
action_type(communicate_non_renewal).
action_label(communicate_non_renewal, 'Communicate intent not to renew').
action_type(communicate_penalty).
action_label(communicate_penalty, 'Communicate penalty').
action_type(compensate_damages_from_refusal).
action_label(compensate_damages_from_refusal, 'Compensate for refusal damages').
action_type(complement_or_replace_guarantee).
action_label(complement_or_replace_guarantee, 'Complement or replace guarantee').
action_type(comply_with_bndes_information_security_policy).
action_label(comply_with_bndes_information_security_policy, 'Comply with security policy').
action_type(comply_with_bndes_requirements).
action_label(comply_with_bndes_requirements, 'Comply with requirements').
action_type(comply_with_labor_obligations).
action_label(comply_with_labor_obligations, 'Comply with labor obligations').
action_type(comply_with_security_standards).
action_label(comply_with_security_standards, 'Comply with security standards').
action_type(comply_with_social_security_obligations).
action_label(comply_with_social_security_obligations, 'Comply with social security obligations').
action_type(conduct_inspections_monitor_execution).
action_label(conduct_inspections_monitor_execution, 'Conduct inspections and monitor execution').
action_type(consent_corporate_operations).
action_label(consent_corporate_operations, 'Consent corporate operations').
action_type(control_attendance_punctuality).
action_label(control_attendance_punctuality, 'Control attendance and punctuality').
action_type(convene_contracted_for_alignment_meeting).
action_label(convene_contracted_for_alignment_meeting, 'Convene alignment meeting').
action_type(credit_account).
action_label(credit_account, 'Credit account').
action_type(deduct_multas_from_credit).
action_label(deduct_multas_from_credit, 'Deduct fines from credit').
action_type(deduct_values).
action_label(deduct_values, 'Deduct values').
action_type(deduct_values_power).
action_label(deduct_values_power, 'Power to deduct values').
action_type(deliver_materials_to_bndes).
action_label(deliver_materials_to_bndes, 'Deliver materials to BNDES').
action_type(demand_compliance).
action_label(demand_compliance, 'Demand compliance').
action_type(demand_provision_of_guarantee).
action_label(demand_provision_of_guarantee, 'Demand provision of guarantee').
action_type(designate_contract_manager).
action_label(designate_contract_manager, 'Designate contract manager').
action_type(designate_receiving_committee).
action_label(designate_receiving_committee, 'Designate receiving committee').
action_type(designate_representative).
action_label(designate_representative, 'Designate representative').
action_type(enforce_service_level_agreements).
action_label(enforce_service_level_agreements, 'Enforce service level agreements').
action_type(ensure_safety_of_professionals).
action_label(ensure_safety_of_professionals, 'Ensure safety of professionals').
action_type(ensure_substitute_meets_requirements).
action_label(ensure_substitute_meets_requirements, 'Ensure substitute profile').
action_type(establish_forum_rio_de_janeiro).
action_label(establish_forum_rio_de_janeiro, 'Establish forum in Rio de Janeiro').
action_type(execute_services_according_to_standards).
action_label(execute_services_according_to_standards, 'Execute services according to standards').
action_type(exercise_rights).
action_label(exercise_rights, 'Exercise rights').
action_type(extend_deadline_for_guarantee).
action_label(extend_deadline_for_guarantee, 'Extend guarantee deadline').
action_type(formalize_contract_alteration).
action_label(formalize_contract_alteration, 'Formalize contract alteration').
action_type(guarantee_contract_object_not_infringe_rights).
action_label(guarantee_contract_object_not_infringe_rights, 'Guarantee contract object does not infringe rights').
action_type(inform_bndes_of_violation).
action_label(inform_bndes_of_violation, 'Inform BNDES of violations').
action_type(limit_access_to_involved_professionals).
action_label(limit_access_to_involved_professionals, 'Limit access to professionals').
action_type(maintain_contractual_conditions_in_succession).
action_label(maintain_contractual_conditions_in_succession, 'Maintain contractual conditions in succession').
action_type(maintain_information_secrecy).
action_label(maintain_information_secrecy, 'Maintain secrecy of information').
action_type(maintain_qualification_conditions).
action_label(maintain_qualification_conditions, 'Maintain qualification conditions').
action_type(maintain_qualified_personnel_registry).
action_label(maintain_qualified_personnel_registry, 'Maintain personnel registry').
action_type(make_available_necessary_information).
action_label(make_available_necessary_information, 'Make available information').
action_type(make_payments_to_contracted).
action_label(make_payments_to_contracted, 'Make payments').
action_type(must_demand_compliance).
action_label(must_demand_compliance, 'Must demand compliance').
action_type(must_obtain_bndes_consent_for_succession).
action_label(must_obtain_bndes_consent_for_succession, 'Obtain BNDES consent for succession').
action_type(no_right_to_cede_contract).
action_label(no_right_to_cede_contract, 'No right to cede contract').
action_type(no_right_to_cede_credit).
action_label(no_right_to_cede_credit, 'No right to cede credit').
action_type(no_right_to_indemnification).
action_label(no_right_to_indemnification, 'No right to indemnification').
action_type(no_right_to_issue_credit_title).
action_label(no_right_to_issue_credit_title, 'No right to issue credit title').
action_type(not_access_confidential_bndes_information).
action_label(not_access_confidential_bndes_information, 'Not access confidential info').
action_type(not_allocate_relatives).
action_label(not_allocate_relatives, 'Not allocate relatives').
action_type(not_copy_reproduce_or_retain).
action_label(not_copy_reproduce_or_retain, 'Not copy, reproduce or retain').
action_type(not_include_unforeseen_benefits).
action_label(not_include_unforeseen_benefits, 'Not include unforeseen benefits').
action_type(not_offer_advantage).
action_label(not_offer_advantage, 'Not offer advantage').
action_type(not_use_confidential_info_after_termination).
action_label(not_use_confidential_info_after_termination, 'Not use info after termination').
action_type(notify_contracted_of_investigation).
action_label(notify_contracted_of_investigation, 'Notify of investigation').
action_type(notify_contracted_of_manager_change).
action_label(notify_contracted_of_manager_change, 'Notify manager change').
action_type(notify_contracted_of_penalty).
action_label(notify_contracted_of_penalty, 'Notify of penalty').
action_type(obey_instructions_procedures).
action_label(obey_instructions_procedures, 'Obey instructions and procedures').
action_type(observe_anti_corruption_law).
action_label(observe_anti_corruption_law, 'Observe anti-corruption law').
action_type(observe_code_of_ethics).
action_label(observe_code_of_ethics, 'Observe code of ethics').
action_type(observe_data_protection_law).
action_label(observe_data_protection_law, 'Observe data protection law').
action_type(obtain_guarantor_consent).
action_label(obtain_guarantor_consent, 'Obtain guarantor consent').
action_type(omit_accept_contract_renewal).
action_label(omit_accept_contract_renewal, 'Omit to accept contract renewal').
action_type(omit_communicate_non_renewal).
action_label(omit_communicate_non_renewal, 'Omit to communicate intent not to renew').
action_type(omit_contract_cession).
action_label(omit_contract_cession, 'Omit contract cession').
action_type(omit_credit_cession).
action_label(omit_credit_cession, 'Omit credit cession').
action_type(omit_issue_credit_title).
action_label(omit_issue_credit_title, 'Omit issue credit title').
action_type(orient_professionals_on_cordial_behavior).
action_label(orient_professionals_on_cordial_behavior, 'Orient professionals on cordial behavior').
action_type(pay_contracted_party).
action_label(pay_contracted_party, 'Pay the contracted party').
action_type(pay_taxes_charges).
action_label(pay_taxes_charges, 'Pay taxes and charges').
action_type(penalty_for_failure_to_provide_guarantee).
action_label(penalty_for_failure_to_provide_guarantee, 'Subject to penalty').
action_type(perform_personnel_substitution_within_bndes_timeframe).
action_label(perform_personnel_substitution_within_bndes_timeframe, 'Substitute personnel in BNDES timeframe').
action_type(present_confidentiality_terms).
action_label(present_confidentiality_terms, 'Present confidentiality terms').
action_type(present_cost_information).
action_label(present_cost_information, 'Present cost information').
action_type(present_dif).
action_label(present_dif, 'Present DIF').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(prevent_favoritism).
action_label(prevent_favoritism, 'Prevent favoritism').
action_type(prevent_overtime).
action_label(prevent_overtime, 'Prevent overtime').
action_type(prevent_undue_advantage).
action_label(prevent_undue_advantage, 'Prevent undue advantage').
action_type(provide_contractual_guarantee).
action_label(provide_contractual_guarantee, 'Provide contractual guarantee').
action_type(provide_ethics_code_copy).
action_label(provide_ethics_code_copy, 'Provide ethics code copy').
action_type(provide_opportunity_to_defend).
action_label(provide_opportunity_to_defend, 'Provide opportunity to defend').
action_type(provide_technical_services).
action_label(provide_technical_services, 'Provide technical services').
action_type(provide_to_rfb).
action_label(provide_to_rfb, 'Provide to RFB').
action_type(provide_tools_and_equipment).
action_label(provide_tools_and_equipment, 'Provide tools and equipment').
action_type(provide_uniforms).
action_label(provide_uniforms, 'Provide uniforms').
action_type(provide_written_notice).
action_label(provide_written_notice, 'Provide written notice').
action_type(receive_object).
action_label(receive_object, 'Receive object').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payment_for_technical_services).
action_label(receive_payment_for_technical_services, 'Receive payment for services').
action_type(receive_retroactive_effects).
action_label(receive_retroactive_effects, 'Receive retroactive effects').
action_type(receive_technical_support).
action_label(receive_technical_support, 'Receive technical support').
action_type(refuse_contract_alteration).
action_label(refuse_contract_alteration, 'Refuse contract alteration').
action_type(remove_impeded_agents).
action_label(remove_impeded_agents, 'Remove impeded agents').
action_type(repair_correct_remove_reconstruct_or_replace).
action_label(repair_correct_remove_reconstruct_or_replace, 'Repair, correct, remove, reconstruct or replace').
action_type(repair_damages_bndes_third_parties).
action_label(repair_damages_bndes_third_parties, 'Repair damages to BNDES or third parties').
action_type(report_impediments).
action_label(report_impediments, 'Report impediments').
action_type(request_additives_for_allocated_events).
action_label(request_additives_for_allocated_events, 'No right to request additives').
action_type(request_price_repactuation).
action_label(request_price_repactuation, 'Request price repactuation').
action_type(respect_economic_financial_equilibrium).
action_label(respect_economic_financial_equilibrium, 'Respect economic equilibrium clause').
action_type(return_resources).
action_label(return_resources, 'Return resources').
action_type(review_prices).
action_label(review_prices, 'Review prices').
action_type(right_to_terminate_contract).
action_label(right_to_terminate_contract, 'Right to terminate contract').
action_type(subject_to_deductions).
action_label(subject_to_deductions, 'Subject to deductions').
action_type(subject_to_penalties).
action_label(subject_to_penalties, 'Subject to penalties').
action_type(subject_to_reduced_payments).
action_label(subject_to_reduced_payments, 'Subject to reduced payments').
action_type(submit_substitution_request).
action_label(submit_substitution_request, 'Submit substitution request').
action_type(substitute_personnel).
action_label(substitute_personnel, 'Substitute personnel').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_136_2020).
contract_metadata(contrato_ocs_136_2020, numero_ocs, '136/2020').
contract_metadata(contrato_ocs_136_2020, numero_sap, '4400004284').
contract_metadata(contrato_ocs_136_2020, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇOS').
contract_metadata(contrato_ocs_136_2020, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'ZOOM TECNOLOGIA LTDA']).
contract_metadata(contrato_ocs_136_2020, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_136_2020, contratado, 'ZOOM TECNOLOGIA LTDA').
contract_metadata(contrato_ocs_136_2020, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_136_2020, cnpj_contratado, '06.105.781/0001-65').
contract_metadata(contrato_ocs_136_2020, procedimento_licitatorio, 'Pregão Eletrônico nº 08/2020 - BNDES').
contract_metadata(contrato_ocs_136_2020, data_autorizacao, '30/01/2020').
contract_metadata_raw(contrato_ocs_136_2020, 'ip_ati_deset', '01/2020', 'trecho_literal').
contract_metadata(contrato_ocs_136_2020, data_ip_ati_degat, '24/01/2020').
contract_metadata(contrato_ocs_136_2020, rubrica_orcamentaria, '3101700090').
contract_metadata(contrato_ocs_136_2020, centro_custo, 'BN00004000').
contract_metadata(contrato_ocs_136_2020, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_136_2020, regulamento, 'Regulamento de Formalização, Execução e Fiscalização de Contratos Administrativos do Sistema BNDES').
contract_clause(contrato_ocs_136_2020, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a prestação de serviços técnicos de Tecnologia da Informação e Comunicações (TIC) para organização, desenvolvimento, implantação e execução continuada de atividades de atendimento e suporte técnico remoto e presencial a usuários de soluções de TIC das Empresas do Sistema BNDES, abrangendo a execução de rotinas periódicas, orientação e esclarecimento de dúvidas, configuração e controle de equipamentos, e recebimento, registro, análise, diagnóstico e atendimento de solicitações de usuários por meio de Central de Serviços (Service Desk), conforme especificações constantes do Termo de Referência (Anexo I do Edital do Pregão Eletrônico nº 08/2020 - BNDES) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_136_2020, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 30 (trinta) meses, a contar da data de sua assinatura, podendo ser prorrogado, mediante aditivo contratual, por até 60 (sessenta) meses.  Parágrafo Primeiro Até 90 (noventa) dias antes do término de cada período de vigência contratual, cabe ao CONTRATADO comunicar ao Gestor do Contrato, por escrito, o seu propósito de não prorrogar a vigência por um novo período, sob pena de se presumir a sua anuência em celebrar o aditivo de prorrogação.  Parágrafo Segundo Caso o CONTRATADO se recuse a celebrar aditivo contratual de prorrogação, tendo antes manifestado sua intenção de prorrogar o Contrato ou deixado de manifestar seu propósito de não prorrogar, nos termos do Parágrafo Primeiro desta Cláusula, ficará sujeito às penalidades previstas na Cláusula de Penalidades deste Contrato.').
contract_clause(contrato_ocs_136_2020, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes do Termo de Referência (Anexo I deste Contrato) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.  Parágrafo Primeiro O BNDES convocará o CONTRATADO a comparecer à reunião de alinhamento de expectativas a ser realizada em até 3 (três) dias úteis, a contar da convocação do BNDES. Nesta reunião o BNDES esclarecerá ao CONTRATADO todas as dúvidas relativas à execução do objeto, disponibilizando eventuais documentos necessários ao início dos trabalhos.  Parágrafo Primeiro O CONTRATADO deverá dispor de cadastro de pessoal qualificado para proceder à substituição dos profissionais alocados na execução dos serviços, observado o disposto a seguir: I. a substituição deverá ser realizada no prazo solicitado pelo BNDES; II. o substituto deverá possuir perfil igual ou superior ao do profissional substituído; III. o CONTRATADO deverá submeter ao BNDES um pedido de substituição, indicando o substituto e o profissional a ser substituído, bem como o período de substituição se for o caso. A este pedido deverá ser anexada a documentação que comprove o perfil profissional do substituto, nos termos do Anexo I (Termo de Referência) deste Contrato; IV. a substituição somente poderá ser realizada após a aprovação pelo BNDES;').
contract_clause(contrato_ocs_136_2020, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'Os serviços contratados deverão ser executados de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados pelo BNDES, observados os níveis de serviço descritos no Anexo I (Termo de Referência) deste Contrato.  Parágrafo Único O descumprimento dos níveis de serviço acarretará a aplicação dos índices de redução do preço previstos no Anexo I (Termo de Referência) deste Contrato, sem prejuízo da aplicação das penalidades previstas neste Contrato, quando cabíveis.').
contract_clause(contrato_ocs_136_2020, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do Gestor, mencionado na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo I (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_136_2020, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará ao CONTRATADO, pela execução do objeto contratado, o valor de até R$ 18.499.862,25 (dezoito milhões, quatrocentos e noventa e nove mil, oitocentos e sessenta e dois reais e vinte e cinco centavos), conforme proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento.  Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização ao CONTRATADO.   Parágrafo Quarto O CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato;').
contract_clause(contrato_ocs_136_2020, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, mensalmente, por meio de crédito em conta bancária, em até 10 (dez) dias úteis a contar da data de apresentação do documento fiscal ou equivalente legal (como nota fiscal, fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Termo de Referência) deste Instrumento.  Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte, mediante prévia autorização do BNDES.  Parágrafo Segundo O primeiro documento fiscal ou equivalente legal terá como objeto de cobrança o período compreendido entre o dia de início da prestação dos serviços e o último dia desse mês, e os documentos fiscais ou equivalentes legais subsequentes terão como referência o período compreendido entre o primeiro e o último dia de cada mês. O último documento fiscal ou equivalente legal, por seu turno, referir-se-á ao período compreendido entre o primeiro dia do último mês da prestação dos serviços e o último dia de serviço prestado. Em todos os casos, o documento fiscal ou equivalente legal só poderá ser emitido e apresentado ao BNDES após a efetiva prestação do serviço, respeitado o disposto no Parágrafo anterior.  Parágrafo Terceiro Para toda efetivação de pagamento, o CONTRATADO deverá encaminhar 1 (uma) via do documento fiscal ou equivalente legal à caixa de e-mail nfe@BNDES.gov.br, ou, quando emitido em papel, ao Protocolo do Edifício de Serviços do BNDES no Rio de Janeiro - EDSERJ, localizado na Avenida República do Chile nº 100, Térreo, Centro, Rio de Janeiro, CEP nº 20031-917, no período compreendido entre 10h e 18h.  Parágrafo Quarto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor do Contrato; V. descrição detalhada do objeto executado e dos respectivos valores; VI. período de referência da execução do objeto; VII. nome e número do CNPJ do CONTRATADO, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VIII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; IX. nome e número do banco e da agência, bem como o número da conta corrente da CONTRATADO, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; X. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; XI. CNPJ do tomador do serviço: 33.657.248/0001-89; XII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XIII. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento - DIF; e  Parágrafo Quinto O documento fiscal ou equivalente legal emitido pelo CONTRATADO deverá estar em conformidade com a legislação do Município onde o CONTRATADO esteja estabelecida, cuja regularidade fiscal foi avaliada na etapa de habilitação, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos federais, sob pena de devolução do documento e interrupção do prazo para pagamento.   Parágrafo Sexto Caso o CONTRATADO emita documento fiscal ou equivalente legal autorizado por Município diferente daquele onde se localiza o estabelecimento do BNDES tomador do serviço e destinatário da cobrança, deverá providenciar o cadastro junto à Secretaria Municipal de Fazenda ou órgão equivalente do Município do estabelecimento tomador, salvo quando se aplicar uma das exceções constantes dos incisos do artigo 3º da Lei Complementar Federal nº 116/03.  A inexistência desse cadastro ou o cadastro em item diverso do faturado não constitui impeditivo ao processo de pagamento, mas um ônus a ser suportado pelo CONTRATADO, uma vez que o BNDES está obrigado a reter na fonte a quantia equivalente ao ISS dos serviços faturados, conforme legislação aplicável.  Parágrafo Sétimo Ao documento fiscal ou equivalente legal deverão ser anexados: I. certidões de regularidade fiscal e trabalhista exigidas na fase de habilitação; II. comprovante de que o CONTRATADO é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade;  IV. Comprovantes de adimplemento dos salários e benefícios dos empregados envolvidos diretamente na prestação do serviço, relativos ao mês faturado; V. Guia de Recolhimento do Fundo de Garantia do Tempo de Serviço e de Informações à Previdência Social – GFIP, acompanhada da respectiva Relação de Trabalhadores constantes do arquivo SEFIP, relativos ao mês faturado; e VII. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado.   Parágrafo Oitavo Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal ao CONTRATADO ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Nono Os pagamentos a serem efetuados em favor do CONTRATADO estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pelo CONTRATADO.  Parágrafo Décimo Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pelo CONTRATADO.  Parágrafo Décimo Primeiro Caso não seja apresentada a documentação comprobatória do cumprimento das obrigações trabalhistas (inclusive FGTS) e previdenciárias, junto com o documento fiscal ou equivalente legal, o BNDES comunicará o fato ao CONTRATADO e poderá reter o pagamento da fatura mensal, em valor proporcional ao da obrigação cujo adimplemento não tenha sido comprovado, até que a situação seja regularizada.  Parágrafo Décimo Segundo Na hipótese do Parágrafo anterior, não sendo regularizada a situação no prazo de 15 (quinze) dias, o BNDES, sem prejuízo das penalidades cabíveis, inclusive a rescisão do contrato, poderá efetuar o pagamento das respectivas obrigações diretamente aos profissionais alocados à prestação de serviço, não configurando vínculo empregatício ou implicando em assunção de responsabilidades por quaisquer obrigações dele decorrentes entre o BNDES e os empregados do CONTRATADO. O sindicato representante da categoria dos trabalhadores será notificado para acompanhar o referido pagamento.  Parágrafo Décimo Terceiro Na situação prevista no parágrafo anterior deve o CONTRATADO fornecer ao BNDES de imediato todas as informações e documentos necessários para a efetivação do pagamento direto.   Parágrafo Décimo Quarto Na impossibilidade de pagamento direto pelo BNDES, os valores retidos poderão ser depositados junto à Justiça do Trabalho, com o objetivo de serem utilizados exclusivamente no pagamento de salários e das demais verbas trabalhistas, contribuições sociais e FGTS.  Parágrafo Décimo Quinto Os pagamentos efetuados pelo BNDES diretamente ou através da Justiça do Trabalho aos empregados do CONTRATADO equivalerá para todos os fins de direito à quitação, na exata medida dos pagamentos ou depósitos efetuados, às suas obrigações decorrentes do presente Contrato perante o CONTRATADO  Parágrafo Décimo Sexto Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível ao CONTRATADO, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.'),.
contract_clause(contrato_ocs_136_2020, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO', 'O BNDES e o CONTRATADO têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante repactuação ou revisão de preços.  Parágrafo Primeiro A repactuação de preços, na forma prevista na legislação, poderá ser requerida pelo CONTRATADO a cada período de 12 (doze) meses, sendo o primeiro contado do dia 06/03/2020, data limite para a apresentação da proposta, e os seguintes da data do fato gerador anterior, observando-se que: I. no que tange aos custos decorrentes de mão de obra, determinados por norma coletiva de trabalho, será adotada como data do orçamento a que a proposta se referir e como data do fato gerador anterior a data dos instrumentos coletivos mencionados vigentes à época da proposta ou da repactuação anterior, vedada a inclusão, por ocasião da repactuação, de antecipações e benefícios não previstos originariamente, exceto quando se tornarem obrigatórios por força de instrumento legal ou norma coletiva de trabalho; II. no que diz respeito aos insumos reajustados de acordo com os valores de mercado, o prazo mínimo de 12 (doze) meses para a realização da primeira repactuação de preços será contado da data limite para a apresentação da proposta (Anexo II do Contrato) e, para a realização das repactuações seguintes, o prazo será contado a partir do fato gerador da última repactuação;  III. caso o intervalo entre os fatos geradores seja inferior a 120 (cento e vinte) dias, os pedidos de repactuação poderão ser reunidos em um só procedimento, considerando-se o último fato gerador para a aplicação do inciso I do Parágrafo Quarto desta Cláusula IV. a repactuação será precedida de demonstração analítica do aumento dos custos; V. o CONTRATADO deverá apresentar planilhas de custos comparativas entre a data da formulação da proposta/orçamento e o momento do pedido de repactuação, contemplando os custos unitários envolvidos, evidenciando o quanto o aumento de preços ocorrido repercute no valor contratual então vigente; e VI. deverão ser apresentados os documentos comprobatórios do aumento de custo, tais como, norma coletiva de trabalho, indicadores setoriais, tabelas de fabricantes, valores oficiais de referência e tarifas públicas.   Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta ou da última repactuação e do momento do pedido de revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ou da última repactuação e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar o CONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto contratado, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.   Parágrafo Quarto O CONTRATADO deverá solicitar a repactuação e/ou a revisão de preços até a prorrogação ou o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador da repactuação e/ou da revisão de preços ocorra com antecedência inferior a 60 (sessenta) dias da prorrogação ou do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador, para solicitar a repactuação e/ou a revisão de preços; II. caso a assinatura do aditivo de prorrogação torne superveniente a ocorrência do fato gerador da repactuação, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador, para solicitar a repactuação; III. o BNDES deverá analisar o pedido de repactuação e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso o CONTRATADO não solicite a repactuação e/ou revisão de preços nos prazos fixados acima, não fará jus aos efeitos retroativos ou, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito à repactuação e/ou à revisão.  Parágrafo Quinto O registro do acordo ou convenção coletiva é um requisito para a concessão da repactuação correlata pelo BNDES, cumprindo ao CONTRATADO, na hipótese de celebração de convenção coletiva, notificar judicial ou extrajudicialmente o sindicato competente para a promoção do registro, caso este não o faça em prazo razoável, para que seja deferida a repactuação.  Parágrafo Sexto Se o processo de repactuação e/ou revisão de preços não for concluído até o vencimento do Contrato, e este for prorrogado, sua continuidade após o reequilíbrio econômico-financeiro ficará condicionada à manutenção da proposta do CONTRATADO como a condição mais vantajosa para o BNDES, podendo este: I. realizar negociação de preços junto ao CONTRATADO, de forma a viabilizar a continuidade do ajuste, quando os novos valores fixados após a repactuação e/ou a revisão de preços estiverem acima do patamar apurado no mercado; ou  II. rescindir o Contrato, mediante aviso prévio ao CONTRATADO, com antecedência de 30 (trinta) dias, quando resultar infrutífera a negociação indicada no Inciso anterior.    Parágrafo Sétimo Na ocorrência da hipótese prevista no Inciso II do Parágrafo anterior, o CONTRATADO fará jus à integralidade dos valores apurados no processo de repactuação e/ou revisão de preços até o término do Contrato, não podendo, todavia, reclamar qualquer indenização em razão da rescisão do mesmo.').
contract_clause(contrato_ocs_136_2020, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS', 'O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.   Parágrafo Primeiro A repactuação aludida na Matriz de Riscos deve respeitar o disposto na
contract_clause(contrato_ocs_136_2020, clausula_decima_garantia_contratual, 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL', 'O CONTRATADO prestará, no prazo de até 10 (dez) dias úteis, contados da convocação, sob pena de aplicação de penalidade nos termos deste Contrato, garantia contratual, observadas as condições para sua aceitação estipuladas nos incisos abaixo, no valor de R$ 924.993,11 (novecentos e vinte e quatro mil, novecentos e noventa e três reais e onze centavos), correspondente a 5% (cinco por cento) do valor do presente Contrato, que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas quando da referida convocação; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a) O Instrumento de Apólice de Seguro deve prever expressamente: a.1) pagamento dos prejuízos advindos do não cumprimento do objeto do Contrato;   a.2) cobertura de prejuízos diretos causados ao BNDES decorrentes de culpa ou dolo do CONTRATADO, durante a execução do Contrato; a.3) responsabilidade da seguradora por todas e quaisquer multas de caráter moratório e punitivo aplicadas ao CONTRATADO; a.4) cobertura dos riscos de inadimplemento, pelo CONTRATADO, de dívidas de natureza trabalhista e previdenciária; a.5) hipóteses de exclusão de responsabilidade da seguradora, nos termos das orientações emitidas pela SUSEP e dos limites legais, observando-se que não serão aceitas condições que ampliem indevidamente a relação de riscos não cobertos pelo seguro.   a.6) vigência pelo prazo contratual; a.7) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes; III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a) O Instrumento de Fiança deve prever expressamente: a.1) renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.   Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pelo CONTRATADO durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Em caso de alteração do valor contratual, prorrogação do prazo de vigência do Contrato, utilização total ou parcial da garantia pelo BNDES, ou em situações outras que impliquem em perda ou insuficiência da garantia, o CONTRATADO deverá providenciar a complementação ou substituição da garantia prestada no prazo determinado pelo BNDES ou pactuado em aditivo ou em apostilamento, observadas as condições originais para aceitação da garantia estipuladas nesta Cláusula.   Parágrafo Terceiro Nos demais casos de alteração do Contrato, sempre que o mesmo for garantido por fiança bancária ou seguro garantia, o CONTRATADO deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe ao CONTRATADO obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.').
contract_clause(contrato_ocs_136_2020, clausula_decima_primeira_obrigações_contratado, 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DO CONTRATADO', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; VIII. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; IX. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; X. permitir ao Banco Central do Brasil acesso a termos firmados, documentos e informações atinentes aos serviços prestados, bem como às suas dependências, nos termos do § 1º do artigo 33 da Resolução CMN nº 4.557/2017; XI. apresentar, em até 10 dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal. XII. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo o CONTRATADO ser instado a intervir no processo;  XIII.  responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos serviços, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES; XIV. devolver recursos disponibilizados pelo BNDES e adotar demais providências aplicáveis ao término da vigência deste Contrato. XV. orientar os profissionais alocados na execução dos serviços para que se comportem de forma cordial, e que estejam sempre dentro dos padrões de apresentação e higiene compatíveis com os serviços; XVI. controlar a frequência, a assiduidade e a pontualidade dos empregados alocados na execução dos serviços; XVII. fornecer uniformes a cada um dos empregados alocados na prestação dos serviços, sem quaisquer ônus para eles, observadas as especificações previstas no Anexo I (Termo de Referência) deste Instrumento; XVIII. zelar pela segurança dos profissionais alocados na execução dos serviços, responsabilizando-se por quaisquer acidentes, em serviço, de que venham a ser vítimas; XIX. impedir que os profissionais alocados na execução dos serviços realizem horas extraordinárias, exceto quando devidamente solicitado pelo BNDES, observando-se os limites impostos no Anexo I (Termo de Referência) deste Instrumento; XX. fornecer todas as ferramentas, equipamentos e materiais necessários à execução dos serviços, nos termos dispostos no Anexo I (Termo de Referência) deste Instrumento; XXI. atender às solicitações do BNDES relativas à transição contratual entre o CONTRATADO e o seu sucessor na execução dos serviços, prestando todo o suporte, a fim de que o objeto contratado não seja interrompido.');
contract_clause(contrato_ocs_136_2020, clausula_decima_segunda_obrigações_trabalhistas_e_previdenciárias_do_contratado, 'CLÁUSULA DÉCIMA SEGUNDA – OBRIGAÇÕES TRABALHISTAS E PREVIDENCIÁRIAS DO CONTRATADO', 'O CONTRATADO deverá cumprir todas as obrigações trabalhistas e previdenciárias relativas aos profissionais designados para a prestação de serviço, observando, especialmente, as obrigações seguintes:  I. pagar os salários e demais verbas passadas diretamente ao profissional, por depósito na conta bancária do mesmo aberta pelo CONTRATADO para esse fim, em estabelecimento de crédito próximo ao local de trabalho, no prazo estabelecido pelo Gestor do Contrato; II. observar as obrigações previstas na norma coletiva aplicável à categoria profissional do empregado, inclusive no que diz respeito a pisos salariais; III. atender a legislação relativa à segurança e à medicina do trabalho, e em particular as Normas Regulamentadoras (NR) expedidas pelo Ministério do Trabalho e Emprego.  Parágrafo Primeiro Devem ser mantidos e atualizados pelo CONTRATADO, bem como exibidos por meio de cópias eletrônicas, sempre que solicitadas pelo BNDES, os registros, anotações e documentos que comprovem o cumprimento das obrigações trabalhistas e previdenciárias, tais como:  I. o contrato de trabalho, o regulamento interno da empresa, se houver, a norma coletiva aplicável à categoria profissional do empregado; II. o registro do profissional e a carteira de trabalho e previdência social – CTPS devidamente assinada; III. o Atestado de Saúde Ocupacional (ASO), comprovando a realização das avaliações médicas (admissional, periódica, demissional e, se for o caso, de retorno ao trabalho e de mudança de função) e exames complementares determinados pelo médico do trabalho; IV. documento comprobatório do cadastramento do profissional no regime do PIS/PASEP; V. documento comprobatório do pagamento das contribuições previdenciárias dos empregados e do empregador; VI. cartão, ficha ou livro de ponto assinado pelo profissional, ou documento comprobatório do registro eletrônico de ponto, nos quais constem as horas trabalhadas normais e extraordinárias, se for o caso; VII. recibo de concessão de aviso de férias, a ser dado 30 (trinta) dias antes do respectivo gozo; VIII. documento comprobatório de depósito bancário na conta do profissional referente ao pagamento dos salários mensais e adicionais aplicáveis, férias acrescidas do terço constitucional e décimo terceiro salário (primeira e segunda parcelas); IX. documento comprobatório de pagamento do salário-família, caso devido, por depósito bancário na conta do profissional, aberta nos termos do Inciso I do caput desta Cláusula; X. documento comprobatório de opção e fornecimento de vale-transporte, quando for o caso; XI. documento comprobatório de fornecimento de auxílio-alimentação e de assistência médica e odontológica; XII. documento comprobatório de recolhimento das contribuições devidas aos sindicatos; XIII. documento comprobatório de entrega e do conteúdo da Relação Anual de Informações Sociais (RAIS); XIV. documento que ateste o recebimento pelo profissional de equipamentos de proteção individual ou coletiva, se o serviço assim o exigir; XV. documento comprobatório do recolhimento dos valores devidos ao FGTS nas respectivas contas vinculadas dos profissionais; XVI. documento comprobatório da entrega e do conteúdo do Cadastro Geral de Empregados e Desempregados (CAGED); XVII. cópia da folha de pagamento analítica de qualquer mês da prestação do serviço, em que conste como tomador o BNDES;  XVIII. cópia dos contracheques dos profissionais alocados na execução do serviço, relativos a qualquer mês da prestação de serviço  XIX. documento comprobatório de realização de eventuais cursos de treinamento e reciclagem que forem exigidos por lei ou por este Contrato  XX. em caso de demissão ou rescisão de contrato de trabalho, os seguintes documentos: a) termos que cuidem da demissão ou rescisão do contrato, sua respectiva homologação e quitação de verbas rescisórias, na forma da legislação; b) documento comprobatório da concessão de aviso prévio pelo CONTRATADO ou pelo profissional; c) documento comprobatório da entrega dos documentos necessários à obtenção de seguro-desemprego pelo profissional, nas hipóteses em que o mesmo faça jus ao benefício; d) guias de recolhimento do FGTS e das contribuições sociais devidas;  e) extratos dos depósitos efetuados nas contas vinculadas individuais do FGTS de cada profissional dispensado; e  f) Atestado de Saúde Ocupacional (ASO), comprovando a realização do exame médico demissional, quando exigível.  Parágrafo Segundo Fica estabelecido que o CONTRATADO é considerado, para todos os fins e efeitos jurídicos, como único e exclusivo empregador dos profissionais alocados à prestação de serviço, sendo o responsável pelo cumprimento das obrigações trabalhistas e previdenciárias, cabendo-lhe reembolsar o BNDES ou suas subsidiárias de todas as despesas que estes tiverem, inclusive custas, emolumentos e honorários advocatícios, resultantes de sua condenação judicial a honrar obrigações trabalhistas ou previdenciárias, ou ainda a pagar indenizações decorrentes das relações de trabalho.');
contract_clause(contrato_ocs_136_2020, clausula_decima_terceira_conduta_etica, 'CLÁUSULA DÉCIMA TERCEIRA – CONDUTA ÉTICA DO CONTRATADO E DO BNDES', 'O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar o Código de Ética do Sistema BNDES vigente ao tempo da contratação, bem como a Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_136_2020, clausula_decima_quarta_sigilo, 'CLÁUSULA DÉCIMA QUARTA – SIGILO DAS INFORMAÇÕES', 'Cabe ao CONTRATADO cumprir as seguintes regras de sigilo e assegurar a aceitação e adesão às mesmas por profissionais que integrem ou venham a integrar a sua equipe na prestação do objeto deste Contrato, as quais perdurarão, inclusive, após a cessação do vínculo contratual e da prestação dos serviços: I. cumprir as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES, necessárias para assegurar a integridade e o sigilo das informações;  II. não acessar informações sigilosas do BNDES, salvo quando previamente autorizado por escrito; III. sempre que tiver acesso às informações mencionadas no inciso anterior: a) manter sigilo dessas informações, não podendo copiá-las, reproduzi-las, retê-las ou praticar qualquer outra forma de uso que não seja imprescindível para a adequada prestação do objeto deste Contrato; b) limitar o acesso às informações aos profissionais envolvidos na prestação dos serviços objeto deste Contrato, os quais deverão estar cientes da natureza sigilosa das informações e das obrigações e responsabilidades decorrentes do uso dessas informações; e c) informar imediatamente ao BNDES qualquer violação das regras de sigilo ora estabelecidas que tenha ocorrido por sua ação ou omissão, independente da existência de dolo, bem como dos profissionais envolvidos, adotando todas as orientações do BNDES para remediar a violação; IV. entregar ao BNDES, ao término da vigência deste Contrato, todo e qualquer material de propriedade deste, inclusive notas pessoais envolvendo matéria sigilosa e registro de documentos de qualquer natureza que tenham sido criados, usados ou mantidos sob seu controle ou posse, assumindo o compromisso de não utilizar qualquer informação sigilosa a que teve acesso no âmbito deste Contrato;  V. apresentar, antes do início da prestação dos serviços, Termos de Confidencialidade, conforme minuta constante do Anexo IV (Minuta de Termo de Confidencialidade para Profissionais) deste Contrato, assinados pelos profissionais que acessarão informações sigilosas, devendo referida obrigação ser também cumprida por ocasião de substituição desses profissionais; e VI. observar o disposto no Termo de Confidencialidade assinado por seu Representante Legal constante do Anexo III (Termo de Confidencialidade para Representante Legal) deste Contrato.').
contract_clause(contrato_ocs_136_2020, clausula_decima_quinta_obrigacoes_bndes, 'CLÁUSULA DÉCIMA QUINTA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos ao CONTRATADO, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Flavia Tacques do Rego, atualmente Analista de Sistemas da ATI/DESET/GEAT, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução dos serviços, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita ao CONTRATADO; V. designar a Comissão de Recebimento, a quem caberá o recebimento do objeto;  VI. fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, cópia do Código de Ética do Sistema BNDES, da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; VII. colocar à disposição do CONTRATADO todas as informações necessárias à perfeita execução dos serviços objeto deste Contrato; e VIII. comunicar ao CONTRATADO, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares do CONTRATADO, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_136_2020, clausula_decima_sexta_cessao, 'CLÁUSULA DÉCIMA SEXTA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL', 'É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro É admitida a sucessão contratual nas hipóteses em que o CONTRATADO realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo, por conseguinte, jus ao recebimento dos créditos dele decorrentes.').
contract_clause(contrato_ocs_136_2020, clausula_decima_setima_penalidades, 'CLÁUSULA DÉCIMA SÉTIMA – PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: I. advertência; II. multa: A) de até 5% (cinco por cento), sobre o valor do respectivo serviço na fatura relativa ao mês de ocorrência do evento, caso o CONTRATADO utilize indevidamente e de forma deliberada o Sistema de Gerenciamento de Serviços de TI ou adote práticas inadequadas de atendimento telefônico com o objetivo de distorcer a apuração dos indicadores de níveis de serviço; B) de até 10% (dez por cento), incidente sobre o valor do respectivo serviço na fatura relativa ao mês de ocorrência do evento, em virtude de qualquer descumprimento contratual não previsto na alínea anterior, apurada de acordo com a gravidade da infração; e III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades indicadas nesta Cláusula somente poderão ser aplicadas após procedimento administrativo, e desde que assegurados o contraditório e a ampla defesa, facultada ao CONTRATADO a defesa prévia, no prazo de 10 (dez) dias úteis.  Parágrafo Segundo  Contra a decisão de aplicação de penalidade, o CONTRATADO poderá interpor o recurso cabível, na forma e no prazo previstos no Regulamento de Formalização, Execução e Fiscalização de Contratos Administrativos do Sistema BNDES.  Parágrafo Terceiro  A imposição de penalidade prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto  A multa prevista nesta Cláusula poderá ser aplicada juntamente com as demais penalidades, observando-se que o total de multas aplicado ao longo da vigência do Contrato não poderá exceder a 30% (trinta por cento) do valor global do Contrato.  Parágrafo Quinto  A multa aplicada ao CONTRATADO e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ele devidos, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto  No caso de uso indevido de informações sigilosas, observar-se-ão, no que couber, os termos da Lei nº 12.527/2011 e do Decreto nº 7.724/2012.  Parágrafo Sétimo  No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Oitavo A sanção prevista no inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_136_2020, clausula_decima_oitava_alteracoes_contratuais, 'CLÁUSULA DÉCIMA OITAVA – ALTERAÇÕES CONTRATUAIS  O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:  I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo       A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.     Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento e os pequenos ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato, que poderão ser celebrados por meio epistolar.', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:  I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo       A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.     Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento e os pequenos ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato, que poderão ser celebrados por meio epistolar.').
contract_clause(contrato_ocs_136_2020, clausula_decima_nona_extincao_contrato, 'CLÁUSULA DÉCIMA NONA – EXTINÇÃO DO CONTRATO O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, convencionando-se, ainda, que é cabível a sua resolução: I. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. na hipótese de não pagamento dos salários e demais verbas trabalhistas, bem como de não recolhimento das contribuições sociais, previdenciárias e para com o Fundo de Garantia do Tempo de Serviço – FGTS; III. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; IV. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo;  V. quando for decretada a falência do CONTRATADO; VI. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VII. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual; VIII. caso o CONTRATADO seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  IX. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; X. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; XI. caso o quantitativo de usuários medido mensalmente seja inferior ao mínimo estabelecido no Termo de Referência durante 3 (três) meses seguidos;  XII. em caso de descumprimento recorrente dos níveis de serviço estabelecidos no Termo de Referência.  XIII. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, convencionando-se, ainda, que é cabível a sua resolução: I. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. na hipótese de não pagamento dos salários e demais verbas trabalhistas, bem como de não recolhimento das contribuições sociais, previdenciárias e para com o Fundo de Garantia do Tempo de Serviço – FGTS; III. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; IV. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo;  V. quando for decretada a falência do CONTRATADO; VI. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VII. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual; VIII. caso o CONTRATADO seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  IX. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; X. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; XI. caso o quantitativo de usuários medido mensalmente seja inferior ao mínimo estabelecido no Termo de Referência durante 3 (três) meses seguidos;  XII. em caso de descumprimento recorrente dos níveis de serviço estabelecidos no Termo de Referência.  XIII. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_136_2020, clausula_vigésima_disposicoes_finais, 'CLÁUSULA VIGÉSIMA – DISPOSIÇÕES FINAIS Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram o presente Contrato: Anexo I - Termo de Referência do Pregão Eletrônico nº 08/2020 - BNDES Anexo II - Proposta Anexo III - Matriz de Risco Anexo IV - Termo de Confidencialidade para Representante Legal Anexo V - Minuta de Termo de Confidencialidade para Profissionais    Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram o presente Contrato: Anexo I - Termo de Referência do Pregão Eletrônico nº 08/2020 - BNDES Anexo II - Proposta Anexo III - Matriz de Risco Anexo IV - Termo de Confidencialidade para Representante Legal Anexo V - Minuta de Termo de Confidencialidade para Profissionais    Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_136_2020, clausula_vigésima_primeira_foro, 'CLÁUSULA VIGÉSIMA PRIMEIRA – FORO  É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As folhas deste Contrato são conferidas por Ana Paula Soeiro de Britto, advogada do BNDES, apenas para conferência de sua redação, por autorização do representante legal que o assina.  E, por estarem assim justos e contratados, firmam o presente Instrumento, juntamente com as testemunhas abaixo.  As partes consideram, para todos os efeitos, a data da última assinatura, como a da formalização jurídica deste instrumento.   Rio de Janeiro, _____ de __________ de _____.   _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES    _____________________________________________________________________ ZOOM TECNOLOGIA LTDA.   Testemunhas:  _________________________________ _________________________________ Nome/CPF: Nome/CPF: GUILHERME NUNES SILVA:05385266965Assinado de forma digital por GUILHERME NUNES SILVA:05385266965 Dados: 2020.06.24 16:03:38 -03\'00\'HERILMAR POMPERMAYER FREIRE:00181257785Assinado de forma digital por HERILMAR POMPERMAYER FREIRE:00181257785 Dados: 2020.06.25 16:04:16 -03\'00\'FERNANDO PASSERI LAVRADO:00486757765Assinado de forma digital por FERNANDO PASSERI LAVRADO:00486757765 Dados: 2020.07.01 14:24:15 -03\'00\'', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As folhas deste Contrato são conferidas por Ana Paula Soeiro de Britto, advogada do BNDES, apenas para conferência de sua redação, por autorização do representante legal que o assina.  E, por estarem assim justos e contratados, firmam o presente Instrumento, juntamente com as testemunhas abaixo.  As partes consideram, para todos os efeitos, a data da última assinatura, como a da formalização jurídica deste instrumento.   Rio de Janeiro, _____ de __________ de _____.   _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES    _____________________________________________________________________ ZOOM TECNOLOGIA LTDA.   Testemunhas:  _________________________________ _________________________________ Nome/CPF: Nome/CPF: GUILHERME NUNES SILVA:05385266965Assinado de forma digital por GUILHERME NUNES SILVA:05385266965 Dados: 2020.06.24 16:03:38 -03\'00\'HERILMAR POMPERMAYER FREIRE:00181257785Assinado de forma digital por HERILMAR POMPERMAYER FREIRE:00181257785 Dados: 2020.06.25 16:04:16 -03\'00\'FERNANDO PASSERI LAVRADO:00486757765Assinado de forma digital por FERNANDO PASSERI LAVRADO:00486757765 Dados: 2020.07.01 14:24:15 -03\'00\'').

% ===== END =====
