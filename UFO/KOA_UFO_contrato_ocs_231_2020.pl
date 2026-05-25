% ===== KOA Combined Output | contract_id: contrato_ocs_231_2020 =====

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
% UFO-only grounding generated from: KOA_Contrato_OCS_231_2020_-_Microstrategy.pl
% contract_id: contrato_ocs_231_2020

instance_of(contrato_ocs_231_2020, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(microstrategy_brasil_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_231_2020).
plays_role(microstrategy_brasil_ltda, hired_service_provider_role, contrato_ocs_231_2020).

clause_of(clausula_primeira_objeto, contrato_ocs_231_2020).
clause_of(clausula_segunda_vigencia, contrato_ocs_231_2020).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_231_2020).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_231_2020).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_231_2020).
clause_of(clausula_sexta_preco, contrato_ocs_231_2020).
clause_of(clausula_setima_pagamento, contrato_ocs_231_2020).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_231_2020).
clause_of(clausula_decima_garantia_contratual, contrato_ocs_231_2020).
clause_of(clausula_decima_primeira_obrigações_contratada, contrato_ocs_231_2020).
clause_of(clausula_decima_segunda_conduta_etica_contratada_bndes, contrato_ocs_231_2020).
clause_of(clausula_decima_terceira_sigilo_informacoes, contrato_ocs_231_2020).
clause_of(clausula_decima_quarta_obrigações_bndes, contrato_ocs_231_2020).
clause_of(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, contrato_ocs_231_2020).
clause_of(clausula_decima_sexta_penalidades, contrato_ocs_231_2020).
clause_of(clausula_decima_setima_alteracoes_contratuais, contrato_ocs_231_2020).
clause_of(clausula_decima_oitava_extincao_contrato, contrato_ocs_231_2020).
clause_of(clausula_decima_nona_disposicoes_finais, contrato_ocs_231_2020).
clause_of(clausula_vigesima_primeira_foro, contrato_ocs_231_2020).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_231_2020).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, microstrategy_brasil_ltda, provide_microstrategy_support).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_microstrategy_support).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, microstrategy_brasil_ltda, communicate_intention_not_to_extend).
legal_relation_instance(clausula_segunda_vigencia, subjection, microstrategy_brasil_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_segunda_vigencia, right_to_omission, microstrategy_brasil_ltda, omit_communication_of_intention_not_to_extend).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, microstrategy_brasil_ltda, execute_service_per_basic_project).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_service_per_basic_project).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, microstrategy_brasil_ltda, execute_service_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_consequences_for_non_compliance).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, microstrategy_brasil_ltda, be_subject_to_consequences_for_non_compliance).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_service_according_to_standards).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_receipt_of_object).
legal_relation_instance(clausula_quinta_recebimento_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_receipt_of_object).
legal_relation_instance(clausula_sexta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_party).
legal_relation_instance(clausula_sexta_preco, right_to_action, microstrategy_brasil_ltda, receive_payment).
legal_relation_instance(clausula_sexta_preco, duty_to_act, microstrategy_brasil_ltda, bear_costs_of_errors).
legal_relation_instance(clausula_sexta_preco, subjection, microstrategy_brasil_ltda, values_proportional_reduction).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, microstrategy_brasil_ltda, present_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_payment_without_attest).
legal_relation_instance(clausula_setima_pagamento, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_amounts).
legal_relation_instance(clausula_setima_pagamento, right_to_action, microstrategy_brasil_ltda, receive_payment).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_payment_if_divergences).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_economic_financial_equilibrium).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, microstrategy_brasil_ltda, request_price_adjustment).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, microstrategy_brasil_ltda, formulate_revision_request).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, microstrategy_brasil_ltda, present_information_for_price_reduction).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, microstrategy_brasil_ltda, request_price_adjustment_or_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_price_adjustment_or_revision_request).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, microstrategy_brasil_ltda, provide_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, microstrategy_brasil_ltda, complement_or_replace_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, microstrategy_brasil_ltda, obtain_guarantor_consent).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, microstrategy_brasil_ltda, obtain_new_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalty).
legal_relation_instance(clausula_decima_garantia_contratual, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extend_guarantee_presentation_period).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_rejecting_extension_request).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, microstrategy_brasil_ltda, maintain_qualification_conditions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, microstrategy_brasil_ltda, communicate_penalty_impediment).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, microstrategy_brasil_ltda, repair_contract_object).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, microstrategy_brasil_ltda, repair_damages).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, microstrategy_brasil_ltda, pay_taxes_and_charges).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, microstrategy_brasil_ltda, provide_exclusion_simples_nacional).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, microstrategy_brasil_ltda, allow_inspections).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, microstrategy_brasil_ltda, obey_bndes_instructions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, microstrategy_brasil_ltda, designate_representative).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, microstrategy_brasil_ltda, allow_central_bank_access).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, microstrategy_brasil_ltda, not_offer_undue_advantage).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_omit, microstrategy_brasil_ltda, permit_favoritism_bndes_employee).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_omit, microstrategy_brasil_ltda, allocate_bndes_employee_family).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, microstrategy_brasil_ltda, observe_bndes_ethics_code).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, microstrategy_brasil_ltda, adopt_good_environmental_practices).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, microstrategy_brasil_ltda, remove_agents_causing_impediments).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, microstrategy_brasil_ltda, communicate_impediments_to_bndes).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, microstrategy_brasil_ltda, comply_with_bndes_security_policy).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_omit, microstrategy_brasil_ltda, not_access_confidential_info_without_authorization).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, microstrategy_brasil_ltda, maintain_secrecy_of_information).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, microstrategy_brasil_ltda, limit_access_to_info).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, microstrategy_brasil_ltda, inform_bndes_of_security_breach).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, microstrategy_brasil_ltda, return_material_to_bndes).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_omit, microstrategy_brasil_ltda, not_use_confidential_info_after_contract).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, microstrategy_brasil_ltda, observe_confidentiality_agreement).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments_to_contracted).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, right_to_action, microstrategy_brasil_ltda, receive_payments).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, change_contract_manager).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_ethics_code).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_needed_information).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_investigation).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_penalty).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, right_to_action, microstrategy_brasil_ltda, request_ethics_code).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, duty_to_omit, microstrategy_brasil_ltda, omit_contract_assignment).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, no_right_to_action, microstrategy_brasil_ltda, no_right_assign_contract).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, duty_to_omit, microstrategy_brasil_ltda, omit_credit_assignment).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, no_right_to_action, microstrategy_brasil_ltda, no_right_assign_credit).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, duty_to_omit, microstrategy_brasil_ltda, omit_issuing_credit_title).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, no_right_to_action, microstrategy_brasil_ltda, no_right_issue_credit_title).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, duty_to_omit, microstrategy_brasil_ltda, omit_contractual_succession).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, no_right_to_action, microstrategy_brasil_ltda, no_right_contractual_succession).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, duty_to_omit, microstrategy_brasil_ltda, omit_subcontracting).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, no_right_to_action, microstrategy_brasil_ltda, no_right_subcontracting).
legal_relation_instance(clausula_decima_sexta_penalidades, subjection, microstrategy_brasil_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_decima_sexta_penalidades, right_to_action, microstrategy_brasil_ltda, present_defense).
legal_relation_instance(clausula_decima_sexta_penalidades, right_to_action, microstrategy_brasil_ltda, interpose_appeal).
legal_relation_instance(clausula_decima_sexta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_sexta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extinguish_contract).
legal_relation_instance(clausula_decima_sexta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_credits).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alter_contract_agreement).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, answer_for_damages).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, liable_for_damages).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_alteration).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, no_right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, not_refuse_alteration).
legal_relation_instance(clausula_decima_oitava_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_other_party).
legal_relation_instance(clausula_decima_oitava_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_oitava_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, present_defense).
legal_relation_instance(clausula_decima_nona_disposicoes_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, establish_waiver_or_novation).
legal_relation_instance(clausula_decima_nona_disposicoes_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights).
legal_relation_instance(clausula_vigesima_primeira_foro, power, unknown, adjudicate_disputes).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_omit, microstrategy_brasil_ltda, omit_making_additives_for_allocated_events).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_making_additives_for_allocated_events_bndes).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, microstrategy_brasil_ltda, respect_economic_financial_equilibrium).

% --- Action catalog (local to this contract grounding) ---
action_type(adjudicate_disputes).
action_label(adjudicate_disputes, 'Adjudicate disputes').
action_type(adopt_good_environmental_practices).
action_label(adopt_good_environmental_practices, 'Adopt good environmental practices').
action_type(allocate_bndes_employee_family).
action_label(allocate_bndes_employee_family, 'Not allocate BNDES family').
action_type(allow_central_bank_access).
action_label(allow_central_bank_access, 'Allow Central Bank access').
action_type(allow_inspections).
action_label(allow_inspections, 'Allow inspections').
action_type(alter_contract_agreement).
action_label(alter_contract_agreement, 'Alter contract by agreement').
action_type(analyze_price_adjustment_or_revision_request).
action_label(analyze_price_adjustment_or_revision_request, 'Analyze price adjustment/revision').
action_type(analyze_risks_succession).
action_label(analyze_risks_succession, 'Analyze risks succession').
action_type(answer_for_damages).
action_label(answer_for_damages, 'Answer for damages').
action_type(apply_consequences_for_non_compliance).
action_label(apply_consequences_for_non_compliance, 'Apply consequences for non-compliance').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_penalty).
action_label(apply_penalty, 'Apply penalty').
action_type(be_subject_to_consequences_for_non_compliance).
action_label(be_subject_to_consequences_for_non_compliance, 'Subject to consequences for non-compliance').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Subject to penalties').
action_type(bear_costs_of_errors).
action_label(bear_costs_of_errors, 'Bear costs of errors').
action_type(change_contract_manager).
action_label(change_contract_manager, 'Change contract manager').
action_type(communicate_impediments_to_bndes).
action_label(communicate_impediments_to_bndes, 'Communicate to BNDES').
action_type(communicate_instructions).
action_label(communicate_instructions, 'Communicate instructions').
action_type(communicate_intention_not_to_extend).
action_label(communicate_intention_not_to_extend, 'Communicate intent not to extend').
action_type(communicate_investigation).
action_label(communicate_investigation, 'Communicate investigation').
action_type(communicate_penalty).
action_label(communicate_penalty, 'Communicate penalty').
action_type(communicate_penalty_impediment).
action_label(communicate_penalty_impediment, 'Communicate penalty').
action_type(complement_or_replace_guarantee).
action_label(complement_or_replace_guarantee, 'Complement/replace guarantee').
action_type(comply_with_bndes_security_policy).
action_label(comply_with_bndes_security_policy, 'Comply with BNDES security policy').
action_type(comply_with_security_norms).
action_label(comply_with_security_norms, 'Comply with security norms').
action_type(consent_to_succession).
action_label(consent_to_succession, 'Consent to succession').
action_type(deduct_amounts).
action_label(deduct_amounts, 'Deduct amounts').
action_type(deduct_credits).
action_label(deduct_credits, 'Deduct credits').
action_type(demand_service_according_to_standards).
action_label(demand_service_according_to_standards, 'Demand service execution').
action_type(designate_contract_manager).
action_label(designate_contract_manager, 'Designate contract manager').
action_type(designate_representative).
action_label(designate_representative, 'Designate representative').
action_type(effect_receipt_of_object).
action_label(effect_receipt_of_object, 'Effect receipt of object').
action_type(establish_waiver_or_novation).
action_label(establish_waiver_or_novation, 'Establish waiver/novation').
action_type(execute_service_according_to_standards).
action_label(execute_service_according_to_standards, 'Execute service according to standards').
action_type(execute_service_per_basic_project).
action_label(execute_service_per_basic_project, 'Execute service as per basic project').
action_type(exercise_rights).
action_label(exercise_rights, 'Exercise rights').
action_type(expect_service_per_basic_project).
action_label(expect_service_per_basic_project, 'Expect service as per basic project').
action_type(extend_guarantee_presentation_period).
action_label(extend_guarantee_presentation_period, 'Extend guarantee presentation period').
action_type(extinguish_contract).
action_label(extinguish_contract, 'Extinguish contract').
action_type(formalize_contract_alteration).
action_label(formalize_contract_alteration, 'Formalize contract alteration').
action_type(formulate_revision_request).
action_label(formulate_revision_request, 'Formulate revision request').
action_type(guarantee_no_infringement).
action_label(guarantee_no_infringement, 'Guarantee no infringement').
action_type(inform_bndes_of_security_breach).
action_label(inform_bndes_of_security_breach, 'Inform BNDES of security breach').
action_type(interpose_appeal).
action_label(interpose_appeal, 'Interpose appeal').
action_type(liable_for_damages).
action_label(liable_for_damages, 'Liable for damages').
action_type(limit_access_to_info).
action_label(limit_access_to_info, 'Limit access to information').
action_type(maintain_qualification_conditions).
action_label(maintain_qualification_conditions, 'Maintain qualification conditions').
action_type(maintain_secrecy_of_information).
action_label(maintain_secrecy_of_information, 'Maintain secrecy of information').
action_type(make_payment).
action_label(make_payment, 'Make payment').
action_type(make_payments_to_contracted).
action_label(make_payments_to_contracted, 'Make payments').
action_type(no_right_assign_contract).
action_label(no_right_assign_contract, 'No right to assign contract').
action_type(no_right_assign_credit).
action_label(no_right_assign_credit, 'No right to assign credit').
action_type(no_right_contractual_succession).
action_label(no_right_contractual_succession, 'No right to contractual succession').
action_type(no_right_issue_credit_title).
action_label(no_right_issue_credit_title, 'No right to issue credit title').
action_type(no_right_subcontracting).
action_label(no_right_subcontracting, 'No right to subcontract').
action_type(not_access_confidential_info_without_authorization).
action_label(not_access_confidential_info_without_authorization, 'Not access confidential information without authorization').
action_type(not_offer_undue_advantage).
action_label(not_offer_undue_advantage, 'Not offer undue advantage').
action_type(not_refuse_alteration).
action_label(not_refuse_alteration, 'Must not refuse alteration').
action_type(not_use_confidential_info_after_contract).
action_label(not_use_confidential_info_after_contract, 'Not use confidential info after contract').
action_type(notify_other_party).
action_label(notify_other_party, 'Notify other party').
action_type(obey_bndes_instructions).
action_label(obey_bndes_instructions, 'Obey instructions').
action_type(observe_bndes_ethics_code).
action_label(observe_bndes_ethics_code, 'Observe BNDES ethics code').
action_type(observe_confidentiality_agreement).
action_label(observe_confidentiality_agreement, 'Observe confidentiality agreement').
action_type(obtain_guarantor_consent).
action_label(obtain_guarantor_consent, 'Obtain guarantor consent').
action_type(obtain_new_guarantee).
action_label(obtain_new_guarantee, 'Obtain new guarantee').
action_type(omit_communication_of_intention_not_to_extend).
action_label(omit_communication_of_intention_not_to_extend, 'Omit communication of intent not to extend').
action_type(omit_contract_assignment).
action_label(omit_contract_assignment, 'Omit contract assignment').
action_type(omit_contractual_succession).
action_label(omit_contractual_succession, 'Omit contractual succession').
action_type(omit_credit_assignment).
action_label(omit_credit_assignment, 'Omit credit assignment').
action_type(omit_issuing_credit_title).
action_label(omit_issuing_credit_title, 'Omit issuing credit title').
action_type(omit_making_additives_for_allocated_events).
action_label(omit_making_additives_for_allocated_events, 'Omit making additives for allocated events.').
action_type(omit_making_additives_for_allocated_events_bndes).
action_label(omit_making_additives_for_allocated_events_bndes, 'Omit making additives for allocated events.').
action_type(omit_payment_if_divergences).
action_label(omit_payment_if_divergences, 'Omit payment if divergences').
action_type(omit_payment_without_attest).
action_label(omit_payment_without_attest, 'Omit payment without attest').
action_type(omit_rejecting_extension_request).
action_label(omit_rejecting_extension_request, 'Omit reject extension request').
action_type(omit_subcontracting).
action_label(omit_subcontracting, 'Omit subcontracting').
action_type(pay_contracted_party).
action_label(pay_contracted_party, 'Pay the contracted party').
action_type(pay_taxes_and_charges).
action_label(pay_taxes_and_charges, 'Pay taxes').
action_type(permit_favoritism_bndes_employee).
action_label(permit_favoritism_bndes_employee, 'Prevent favoritism').
action_type(present_defense).
action_label(present_defense, 'Present defense').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(present_information_for_price_reduction).
action_label(present_information_for_price_reduction, 'Present info for price reduction').
action_type(provide_contractual_guarantee).
action_label(provide_contractual_guarantee, 'Provide contractual guarantee').
action_type(provide_ethics_code).
action_label(provide_ethics_code, 'Provide ethics code').
action_type(provide_exclusion_simples_nacional).
action_label(provide_exclusion_simples_nacional, 'Provide exclusion from Simples Nacional').
action_type(provide_microstrategy_support).
action_label(provide_microstrategy_support, 'Provide Microstrategy support').
action_type(provide_needed_information).
action_label(provide_needed_information, 'Provide needed information').
action_type(receive_fiscal_document).
action_label(receive_fiscal_document, 'Receive fiscal document').
action_type(receive_microstrategy_support).
action_label(receive_microstrategy_support, 'Receive Microstrategy support').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payments).
action_label(receive_payments, 'Receive payments').
action_type(remove_agents_causing_impediments).
action_label(remove_agents_causing_impediments, 'Remove Agents').
action_type(repair_contract_object).
action_label(repair_contract_object, 'Repair object').
action_type(repair_damages).
action_label(repair_damages, 'Repair damages').
action_type(request_economic_financial_equilibrium).
action_label(request_economic_financial_equilibrium, 'Request economic-financial equilibrium').
action_type(request_ethics_code).
action_label(request_ethics_code, 'Request ethics code').
action_type(request_needed_information).
action_label(request_needed_information, 'Request needed information').
action_type(request_price_adjustment).
action_label(request_price_adjustment, 'Request price adjustment').
action_type(request_price_adjustment_or_revision).
action_label(request_price_adjustment_or_revision, 'Request price adjustment/revision').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(respect_economic_financial_equilibrium).
action_label(respect_economic_financial_equilibrium, 'Respect economic-financial equilibrium.').
action_type(return_material_to_bndes).
action_label(return_material_to_bndes, 'Return material to BNDES').
action_type(return_resources).
action_label(return_resources, 'Return resources').
action_type(suffer_penalty).
action_label(suffer_penalty, 'Subject to penalty').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').
action_type(values_proportional_reduction).
action_label(values_proportional_reduction, 'Subject to value reduction').
action_type(vistoria_e_acompanhamento).
action_label(vistoria_e_acompanhamento, 'Inspect and oversee').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_231_2020).
contract_metadata(contrato_ocs_231_2020, numero_ocs, '231/2020').
contract_metadata(contrato_ocs_231_2020, numero_sap, '4400004391').
contract_metadata(contrato_ocs_231_2020, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇO').
contract_metadata(contrato_ocs_231_2020, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'MICROSTRATEGY BRASIL LTDA']).
contract_metadata(contrato_ocs_231_2020, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_231_2020, contratado, 'MICROSTRATEGY BRASIL LTDA').
contract_metadata(contrato_ocs_231_2020, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_231_2020, cnpj_contratado, '02.869.307/0001-59').
contract_metadata(contrato_ocs_231_2020, procedimento_licitatorio, 'Inexigibilidade de Licitação nº 048/2020').
contract_metadata(contrato_ocs_231_2020, data_autorizacao, '06/11/2020').
contract_metadata_raw(contrato_ocs_231_2020, 'ip_desis1', '08/2020', 'trecho_literal').
contract_metadata(contrato_ocs_231_2020, data_ip_ati_degat, '05/11/2020').
contract_metadata(contrato_ocs_231_2020, rubrica_orcamentaria, '3101700021').
contract_metadata(contrato_ocs_231_2020, centro_custo, 'BN00004000').
contract_metadata(contrato_ocs_231_2020, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_231_2020, regulamento, 'Regulamento de Formalização, Execução e Fiscalização dos Contratos Administrativos do Sistema BNDES').
contract_clause(contrato_ocs_231_2020, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a prestação dos serviços de suporte técnico do software Microstrategy, conforme especificações constantes do Projeto Básico e da Proposta apresentada pela CONTRATADA, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_231_2020, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 12 (doze) meses, a contar da data de assinatura do contrato, prorrogáveis até o limite de 60 (sessenta) meses.  . Parágrafo Primeiro Até 90 (noventa) dias antes do término de cada período de vigência contratual, cabe à CONTRATADA comunicar ao Gestor do Contrato, por escrito, o seu propósito de não prorrogar a vigência por um novo período, sob pena de se presumir a sua anuência em celebrar o aditivo de prorrogação, nas mesmas condições então vigentes. DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0B Parágrafo Segundo Caso a CONTRATADA se recuse a celebrar aditivo contratual de prorrogação, tendo antes manifestado sua intenção de prorrogar o Contrato ou deixado de manifestar seu propósito de não prorrogar, nos termos do Parágrafo Primeiro desta Cláusula, ficará sujeita às penalidades previstas na Cláusula de Penalidades deste Contrato.').
contract_clause(contrato_ocs_231_2020, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do serviço respeitará as especificações constantes do Projeto Básico.').
contract_clause(contrato_ocs_231_2020, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'O serviço contratado deverá ser executado de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados no Projeto Básico.  Parágrafo Único O descumprimento de qualquer meta de nível de serviço pactuada acarretará a aplicação das consequências previstas no Projeto Básico.').
contract_clause(contrato_ocs_231_2020, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do Gestor mencionado na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Projeto Básico.').
contract_clause(contrato_ocs_231_2020, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará à CONTRATADA, pela execução do objeto contratado, o valor de R$ 130.974,63 (cento e trinta mil, novecentos e setenta e quatro reais e sessenta e três centavos), conforme Proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento.  Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis, se for o caso.  Parágrafo Terceiro A CONTRATADA deverá arcar com os ônus decorrentes de eventual equívoco no DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0Bdimensionamento dos quantitativos de sua Proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua Proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato.').
contract_clause(contrato_ocs_231_2020, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, mensalmente, por meio de crédito em conta bancária, em até 10 (dez) dias úteis a contar da data de apresentação do documento fiscal ou equivalente legal (como nota fiscal, fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Termo de Referência) deste Instrumento.  Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte, mediante prévia autorização do BNDES.  Parágrafo Segundo O primeiro documento fiscal ou equivalente legal terá como objeto de cobrança o período compreendido entre o dia de início da prestação dos serviços e o último dia desse mês, e os documentos fiscais ou equivalentes legais subsequentes terão como referência o período compreendido entre o primeiro e o último dia de cada mês. O último documento fiscal ou equivalente legal, por seu turno, referir-se-á ao período compreendido entre o primeiro dia do último mês da prestação dos serviços e o último dia de serviço prestado. Em todos os casos, o documento fiscal ou equivalente legal só poderá ser emitido e apresentado ao BNDES após a efetiva prestação do serviço, respeitado o disposto no Parágrafo anterior.  Parágrafo Terceiro Para toda efetivação de pagamento, o Contratado deverá encaminhar o documento fiscal ou equivalente em meio digital para caixa postal eletrônica ou protocolar em sistema eletrônico próprio do BNDES, considerando as orientações do Contratante vigentes na ocasião do pagamento. No caso de emissão de documento fiscal exclusivamente em meio físico o mesmo deverá ser encaminhado ao protocolo do BNDES para devido registro de recebimento.  Parágrafo Quarto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0Bminimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor do Contrato. V. descrição detalhada do objeto executado e dos respectivos valores; VI. período de referência da execução do objeto; VII. nome e número do CNPJ da CONTRATADA, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VIII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; IX. nome e número do banco e da agência, bem como o número da conta corrente da CONTRATADA, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; X. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; XI. CNPJ do tomador do serviço: 33.657.248/0001-89; XII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XIII. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento (DIF), bem como o código fiscal de operações e prestações (CFOP), se for o caso.   Parágrafo Quinto O documento fiscal ou equivalente legal emitido pela CONTRATADA deverá estar em conformidade com a legislação do Município onde a CONTRATADA esteja estabelecida, cuja regularidade fiscal foi avaliada na etapa de habilitação, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos federais, sob pena de devolução do documento e interrupção do prazo para pagamento.  Parágrafo Sexto Caso a CONTRATADA emita documento fiscal ou equivalente legal autorizado por Município diferente daquele onde se localiza o estabelecimento do BNDES tomador do serviço e destinatário da cobrança, deverá providenciar o cadastro junto à Secretaria Municipal de Fazenda ou órgão equivalente do Município do estabelecimento tomador, salvo quando se aplicar uma das exceções constantes dos incisos do artigo 3º da Lei Complementar Federal nº 116/03.  A inexistência desse cadastro ou o cadastro em item diverso do faturado não constitui DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0Bimpeditivo ao processo de pagamento, mas um ônus a ser suportado pela CONTRATADA, uma vez que o BNDES está obrigado a reter na fonte a quantia equivalente ao ISS dos serviços faturados, conforme legislação aplicável.  Parágrafo Sétimo Ao documento fiscal ou equivalente legal, deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que a CONTRATADA é optante do Simples Nacional, se for o caso;  III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; IV. demais documentos previstos no Plano de Trabalho.  Parágrafo Oitavo Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal à CONTRATADA ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que esta providencie as medidas saneadoras ou comprove a correção dos dados fundamentada e justificadamente contestados pelo BNDES.   Parágrafo Nono Os pagamentos a serem efetuados em favor da CONTRATADA estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pela CONTRATADA.  Parágrafo Décimo Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pela CONTRATADA. Em qualquer caso, a CONTRATADA emitirá o documento fiscal no valor total conforme Contrato.  Parágrafo Décimo Primeiro Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível à CONTRATADA, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.').
contract_clause(contrato_ocs_231_2020, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO O BNDES e a CONTRATADA têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços. DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0B Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pela CONTRATADA a cada período de 12 (doze) meses, sendo o primeiro contado do dia 30/11/2020, data da cotação prevista na Proposta da CONTRATADA, e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do índice Índice de Custo de Tecnologia da Informação – ICTI, divulgado pelo Instituto de Pesquisa Econômica Aplicada – IPEA, ou outro índice que vier a substituí-lo, sobre o preço referido na Cláusula de Preço deste Instrumento.   Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação da CONTRATADA, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado à CONTRATADA ou ao BNDES nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte:  I. a CONTRATADA deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da Proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, a CONTRATADA deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da Proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado; IV. nos pedidos de revisão solicitados pelo BNDES, este deverá encaminhar correspondência à CONTRATADA, explicitando os motivos e comprovando o fato gerador e então facultar à CONTRATADA a apresentação de manifestação para  demonstrar eventual descabimento da revisão pretendida pelo BNDES, para ser apreciada por este, exceto no caso de alteração das alíquotas dos tributos incidentes cuja aplicação prescindirá deste procedimento.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar a CONTRATADA para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na Proposta, em virtude da redução dos preços de mercado, ou de DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0Bitens que compõem o custo, cabendo à CONTRATADA apresentar as informações solicitadas pelo BNDES e as partes procederem à negociação.  Parágrafo Quarto A CONTRATADA deverá solicitar o reajuste e/ou a revisão de preços até a prorrogação ou o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que:  I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias da prorrogação ou do encerramento do Contrato, a CONTRATADA terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a assinatura do aditivo de prorrogação torne superveniente a ocorrência do fato gerador do reajuste, ou a divulgação do índice de reajuste ocorra após a prorrogação ou o encerramento do Contrato, a CONTRATADA terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pela CONTRATADA dos comprovantes de variação do índice de reajuste do Contrato ou variação dos custos ficando este prazo suspenso, a critério do BNDES, enquanto a CONTRATADA não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso a CONTRATADA não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, não fará jus aos efeitos retroativos ou, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.  Parágrafo Quinto Se o processo de reajuste e/ou revisão de preços não for concluído até o vencimento do Contrato, e este for prorrogado, sua continuidade após o reequilíbrio econômico-financeiro ficará condicionada à manutenção da proposta da CONTRATADA como a condição mais vantajosa para o BNDES, podendo este: I. realizar negociação de preços junto à CONTRATADA, de forma a viabilizar a continuidade do ajuste, quando os novos valores fixados após o reajuste e/ou a revisão de preços estiverem acima do patamar apurado no mercado; ou  II. rescindir o Contrato, mediante aviso prévio à CONTRATADA, com antecedência de 30 (trinta) dias, quando resultar infrutífera a negociação indicada no inciso anterior.  Parágrafo Sexto Na ocorrência da hipótese prevista no inciso II do Parágrafo anterior, a CONTRATADA fará jus DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0Bà integralidade dos valores apurados no processo de reajuste e/ou revisão de preços até o término do Contrato, não podendo, todavia, reclamar qualquer indenização em razão da rescisão do mesmo.', 'clausula_oitava_equilibrio_economico_financeiro_contrato').
contract_clause(contrato_ocs_231_2020, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS O BNDES e a CONTRATADA, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos anexa a esse instrumento.  Parágrafo Primeiro O reajuste de preço aludido na Matriz de Riscos deve respeitar o disposto na
contract_clause(contrato_ocs_231_2020, clausula_decima_garantia_contratual, 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL A CONTRATADA prestará, no prazo de até 20 (vinte) dias úteis, contados da convocação, sob pena de aplicação de penalidade nos termos deste Contrato, garantia contratual, observadas as condições para sua aceitação estipuladas nos incisos abaixo, no valor de R$ 6.548,73 (seis mil, quinhentos e quarenta e oito reais e setenta e três centavos), correspondente a 5 % (cinco_por cento) do valor do presente Contrato, que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais.  I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas quando da referida convocação; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a) O Instrumento de Apólice de Seguro deve prever expressamente: a.1) responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas ao CONTRATADO; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0BIII. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a) O Instrumento de Fiança deve prever expressamente: a.1) renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pelo CONTRATADO durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Em caso de alteração do valor contratual, prorrogação do prazo de vigência do Contrato, utilização total ou parcial da garantia pelo BNDES, ou em situações outras que impliquem em perda ou insuficiência da garantia, o CONTRATADO deverá providenciar a complementação ou substituição da garantia prestada no prazo determinado pelo BNDES ou pactuado em aditivo ou em apostilamento, observadas as condições originais para aceitação da garantia estipuladas nesta Cláusula.   Parágrafo Terceiro Nos demais casos de alteração do Contrato, sempre que o mesmo for garantido por fiança bancária ou seguro garantia, o CONTRATADO deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe ao CONTRATADO obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.', 'clausula_decima_garantia_contratual').
contract_clause(contrato_ocs_231_2020, clausula_decima_primeira_obrigações_contratada, 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DA CONTRATADA Além de outras obrigações estabelecidas neste Instrumento, em seus anexos – especialmente o Anexo I – ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações da CONTRATADA:  I. manter durante a vigência deste Contrato todas as condições de habilitação e qualificação exigidas quando da contratação, comprovando-as sempre que solicitado DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0Bpelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a inexigibilidade de licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução, nos termos e forma do Projeto Básico; IV. reparar todos os danos diretos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir da CONTRATADA a comprovação de sua regularidade; VI. providenciar, perante a Receita Federal do Brasil – RFB, comprovando ao BNDES, sua exclusão obrigatória do  Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se a CONTRATADA, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das exceções previstas no artigo 17 da Lei Complementar nº 123/2006; VII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; VIII. obedecer às instruções e aos procedimentos estabelecidos pelo BNDES para a adequada execução do Contrato, quando este não estiver previsto no Contrato, no Projeto Básico, na Proposta; IX. designar 1 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor da CONTRATADA, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; X. permitir ao Banco Central do Brasil o acesso nos termos do § 1º do artigo 33 da Resolução CMN nº 4.557/2017 ou normativo que o suceda; XI. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo a CONTRATADA ser instada a intervir no processo;  XII. responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos serviços, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES; e XIII. devolver recursos disponibilizados pelo BNDES, revogar perfis de acesso de seus profissionais, eliminar suas caixas postais e adotar demais providências aplicáveis ao DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0Btérmino da vigência do CONTRATO.', 'trecho_literal').
contract_clause(contrato_ocs_231_2020, clausula_decima_segunda_conduta_etica_contratada_bndes, 'CLÁUSULA DÉCIMA SEGUNDA – CONDUTA ÉTICA DA CONTRATADA E DO BNDES A CONTRATADA e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta em preceitos éticos e, em especial, na sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, a CONTRATADA obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar o Código de Ética do Sistema BNDES vigente ao tempo da contratação, bem como a Política de Conduta e Integridade no âmbito das licitações e contratos administrativos e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, à CONTRATADA, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete à CONTRATADA afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0BParágrafo Quarto A CONTRATADA declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e Integridade no âmbito das licitações e contratos administrativos e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).', 'trecho_literal').
contract_clause(contrato_ocs_231_2020, clausula_decima_terceira_sigilo_informacoes, 'CLÁUSULA DÉCIMA TERCEIRA – SIGILO DAS INFORMAÇÕES Cabe à CONTRATADA cumprir as seguintes regras de sigilo e assegurar a aceitação e adesão às mesmas por profissionais que integrem ou venham a integrar a sua equipe na prestação do objeto deste Contrato, as quais perdurarão, inclusive, após a cessação do vínculo contratual e da prestação do serviço:  I. cumprir as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES, necessárias para assegurar a integridade e o sigilo das informações;  II. não acessar informações sigilosas do BNDES, salvo quando previamente autorizado por escrito; III. sempre que tiver acesso às informações mencionadas no Inciso anterior: a) manter sigilo dessas informações, não podendo copiá-las, reproduzi-las, retê-las ou praticar qualquer outra forma de uso que não seja imprescindível para a adequada prestação do objeto deste Contrato; b) limitar o acesso às informações aos profissionais envolvidos na prestação do serviço objeto deste Contrato, os quais deverão estar cientes da natureza sigilosa das informações e das obrigações e responsabilidades decorrentes do uso dessas informações; e c) informar o mais brevemente possível ao BNDES qualquer violação das regras de sigilo ora estabelecidas que tenha ocorrido por sua ação ou omissão, independentemente da existência de dolo, bem como dos profissionais envolvidos, adotando todas as orientações do BNDES para remediar a violação; IV. entregar ao BNDES, ao término da vigência deste Contrato, todo e qualquer material de propriedade deste, inclusive notas pessoais envolvendo matéria sigilosa e registro de documentos de qualquer natureza que tenham sido criados, usados ou mantidos sob seu controle ou posse, assumindo o compromisso de não utilizar qualquer informação sigilosa a que teve acesso no âmbito deste Contrato; e V. observar o disposto no Termo de Confidencialidade assinado por seus representantes legais, anexo a este Contrato. DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0B', 'trecho_literal').
contract_clause(contrato_ocs_231_2020, clausula_decima_quarta_obrigações_bndes, 'CLÁUSULA DÉCIMA QUARTA – OBRIGAÇÕES DO BNDES Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis, vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos à CONTRATADA, nas condições estabelecidas neste Contrato; II. designar, como Gestora do Contrato, a gerente, ou seu substituto, da ATI/DESIS1/GDATA  função atualmente exercida por Gisele Pereira Morgado, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução do serviço, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto (Fernando Antônio Pinhati), por outro profissional, mediante comunicação escrita à CONTRATADA;  IV. fornecer à CONTRATADA, quando solicitado ao Gestor do Contrato, cópia do Código de Ética do Sistema BNDES, da Política de Conduta e Integridade no âmbito das licitações e contratos administrativos, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; V. colocar à disposição da CONTRATADA todas as informações necessárias à perfeita execução do serviço objeto deste Contrato; e VI. comunicar à CONTRATADA, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares da CONTRATADA, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.', 'trecho_literal').
contract_clause(contrato_ocs_231_2020, clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, 'CLÁUSULA DÉCIMA QUINTA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte da CONTRATADA, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro  É vedada a sucessão contratual, salvo nas hipóteses em que a CONTRATADA realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0BII. manutenção de todas as condições contratuais e requisitos de habilitação originais, previstos no Projeto Básico.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É vedada a subcontratação para a execução do objeto deste Contrato.', 'trecho_literal').
contract_clause(contrato_ocs_231_2020, clausula_decima_sexta_penalidades, 'CLÁUSULA DÉCIMA SEXTA – PENALIDADES Em caso de descumprimento parcial ou total do Contrato, a Contratada ficará sujeita às seguintes penalidades, garantida a prévia defesa, sem prejuízo da aplicação do disposto na legislação aplicável:  I - Advertência; II - Multa de 0,1% (um décimo por cento) ao dia, aplicada sobre o valor total do respectivo Contrato até o limite máximo de 10% (dez por cento) do referido valor, por cada dia corrido de atraso, causado pela Contratada, no fornecimento das informações sobre os canais de atendimento para abertura de chamados, conforme descrito no subitem 3.1 deste Projeto Básico; III - Na hipótese da Contratada deixar de garantir o nível de serviço previsto no subitem 4.3 e sendo ultrapassado o limite de ajuste de pagamento estabelecido no subitem 5.1.1, caberá multa de até 1% (um por cento) sobre o valor da respectiva fatura mensal, referente ao serviço de Suporte Técnico e Manutenção, por hora excedente, limitado a 10% (dez por cento) do valor global do respectivo Contrato; IV - Multa de 0,1% (um por cento) ao dia sobre o valor mensal do Serviço de Suporte Técnico e Atualização de Versões, até o limite máximo de 10% (dez por cento) do referido valor, por cada dia corrido de atraso causado pela Contratada no fornecimento do relatório previsto no subitem 5.2 deste Projeto Básico; V – Multa de até 10% incidente sobre o valor global do Contrato, em razão de outros inadimplementos não previstos nas alíneas anteriores, a ser apurado de acordo com a gravidade da infração; VI - Suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0BAs penalidades indicadas nesta Cláusula somente poderão ser aplicadas após procedimento administrativo, e desde que assegurados o contraditório e a ampla defesa, facultada à CONTRATADA a defesa prévia, no prazo de 10 (dez) dias úteis.  Parágrafo Segundo Contra a decisão de aplicação de penalidade, a CONTRATADA poderá interpor o recurso cabível, na forma e no prazo previstos no Regulamento de Formalização, Execução e Fiscalização de Contratos Administrativos do Sistema BNDES.  Parágrafo Terceiro A imposição de sanção prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto A multa prevista nesta Cláusula poderá ser aplicada juntamente com as demais penalidades.  Parágrafo Quinto A multa aplicada e não paga tempestivamente pela CONTRATADA e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ela devidos, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto No caso de uso indevido de informações sigilosas, observar-se-ão, no que couber, os termos da Lei nº 12.527/2011 e do Decreto nº 7.724/2012.  Parágrafo Sétimo No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Oitavo A sanção prevista no Inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que:  I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da contratação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados devidamente comprovados mediante processo administrativo ou judicial. DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0B', 'CLÁUSULA DÉCIMA SEXTA – PENALIDADES Em caso de descumprimento parcial ou total do Contrato, a Contratada ficará sujeita às seguintes penalidades, garantida a prévia defesa, sem prejuízo da aplicação do disposto na legislação aplicável:  I - Advertência; II - Multa de 0,1% (um décimo por cento) ao dia, aplicada sobre o valor total do respectivo Contrato até o limite máximo de 10% (dez por cento) do referido valor, por cada dia corrido de atraso, causado pela Contratada, no fornecimento das informações sobre os canais de atendimento para abertura de chamados, conforme descrito no subitem 3.1 deste Projeto Básico; III - Na hipótese da Contratada deixar de garantir o nível de serviço previsto no subitem 4.3 e sendo ultrapassado o limite de ajuste de pagamento estabelecido no subitem 5.1.1, caberá multa de até 1% (um por cento) sobre o valor da respectiva fatura mensal, referente ao serviço de Suporte Técnico e Manutenção, por hora excedente, limitado a 10% (dez por cento) do valor global do respectivo Contrato; IV - Multa de 0,1% (um por cento) ao dia sobre o valor mensal do Serviço de Suporte Técnico e Atualização de Versões, até o limite máximo de 10% (dez por cento) do referido valor, por cada dia corrido de atraso causado pela Contratada no fornecimento do relatório previsto no subitem 5.2 deste Projeto Básico; V – Multa de até 10% incidente sobre o valor global do Contrato, em razão de outros inadimplementos não previstos nas alíneas anteriores, a ser apurado de acordo com a gravidade da infração; VI - Suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0BAs penalidades indicadas nesta Cláusula somente poderão ser aplicadas após procedimento administrativo, e desde que assegurados o contraditório e a ampla defesa, facultada à CONTRATADA a defesa prévia, no prazo de 10 (dez) dias úteis.  Parágrafo Segundo Contra a decisão de aplicação de penalidade, a CONTRATADA poderá interpor o recurso cabível, na forma e no prazo previstos no Regulamento de Formalização, Execução e Fiscalização de Contratos Administrativos do Sistema BNDES.  Parágrafo Terceiro A imposição de sanção prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto A multa prevista nesta Cláusula poderá ser aplicada juntamente com as demais penalidades.  Parágrafo Quinto A multa aplicada e não paga tempestivamente pela CONTRATADA e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ela devidos, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto No caso de uso indevido de informações sigilosas, observar-se-ão, no que couber, os termos da Lei nº 12.527/2011 e do Decreto nº 7.724/2012.  Parágrafo Sétimo No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Oitavo A sanção prevista no Inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que:  I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da contratação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados devidamente comprovados mediante processo administrativo ou judicial. DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0B').
contract_clause(contrato_ocs_231_2020, clausula_decima_setima_alteracoes_contratuais, 'CLÁUSULA DÉCIMA SÉTIMA – ALTERAÇÕES CONTRATUAIS O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:  I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Projeto Básico.  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos diretos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.  Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento e os pequenos ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato, que poderão ser formalizados por meio epistolar.', 'CLÁUSULA DÉCIMA SÉTIMA – ALTERAÇÕES CONTRATUAIS O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:  I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Projeto Básico.  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos diretos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.  Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento e os pequenos ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato, que poderão ser formalizados por meio epistolar.').
contract_clause(contrato_ocs_231_2020, clausula_decima_oitava_extincao_contrato, 'CLÁUSULA DÉCIMA OITAVA – EXTINÇÃO DO CONTRATO O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, convencionando-se, ainda, que é cabível a sua resolução:  I. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à a inocente notificar a outra por escrito, assinalando-lhe prazo razoável para cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; III. quando for decretada a falência do CONTRATADO; IV. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0Bcontratação; V. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou Créditos, Sucessão Contratual e Subcontratação; VI. caso o CONTRATADO seja declarada inidôneo pela União, por Estado ou pelo Distrito Federal;  VII. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; VIII. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei n.º 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; IX. em razão da dissolução do CONTRATADO; e X. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 30 (trinta) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato e oportunidade de defesa, dispensada a necessidade de interpelação judicial.', 'CLÁUSULA DÉCIMA OITAVA – EXTINÇÃO DO CONTRATO O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, convencionando-se, ainda, que é cabível a sua resolução:  I. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à a inocente notificar a outra por escrito, assinalando-lhe prazo razoável para cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; III. quando for decretada a falência do CONTRATADO; IV. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0Bcontratação; V. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou Créditos, Sucessão Contratual e Subcontratação; VI. caso o CONTRATADO seja declarada inidôneo pela União, por Estado ou pelo Distrito Federal;  VII. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; VIII. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei n.º 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; IX. em razão da dissolução do CONTRATADO; e X. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 30 (trinta) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato e oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_231_2020, clausula_decima_nona_disposicoes_finais, 'CLÁUSULA DÉCIMA  NONA– DISPOSIÇÕES FINAIS Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram este Contrato o Projeto Básico, a Proposta, a Matriz de Risco e os Termo de Confidencialidade, respectivamente, Anexos I, II,  III e IV ao presente Instrumento, no que com este não colidir, bem como com as disposições legais aplicáveis, observando-se que, ocorrendo conflitos de interpretação entre as disposições contratuais e de seus anexos, prevalecerá o disposto no Contrato e na legislação em vigor.  Parágrafo Segundo Caso haja contradição entre os termos da Proposta da CONTRATADA (Anexo II) e o Projeto Básico, (Anexo I), prevalecerá o estabelecido neste último.   Parágrafo Terceiro A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0Bou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.', 'CLÁUSULA DÉCIMA  NONA– DISPOSIÇÕES FINAIS Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram este Contrato o Projeto Básico, a Proposta, a Matriz de Risco e os Termo de Confidencialidade, respectivamente, Anexos I, II,  III e IV ao presente Instrumento, no que com este não colidir, bem como com as disposições legais aplicáveis, observando-se que, ocorrendo conflitos de interpretação entre as disposições contratuais e de seus anexos, prevalecerá o disposto no Contrato e na legislação em vigor.  Parágrafo Segundo Caso haja contradição entre os termos da Proposta da CONTRATADA (Anexo II) e o Projeto Básico, (Anexo I), prevalecerá o estabelecido neste último.   Parágrafo Terceiro A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0Bou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_231_2020, clausula_vigesima_primeira_foro, 'CLÁUSULA VIGÉSIMA PRIMEIRA – FORO  É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As folhas deste Contrato são conferidas por Márcio Oliveira da Rocha, advogado do BNDES, por autorização do representante legal que o assina.  E, por estarem assim justos e contratados, firmam o presente Instrumento, redigido em 1 (uma) via de igual teor e forma, para um só efeito, juntamente com as testemunhas abaixo.  Reputa-se celebrado o presente Contrato na data em que for registrada a última assinatura dos representantes legais do BNDES.  Rio de Janeiro,      de                           de 2020.      _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES       _____________________________________________________________________ MICROCTRATEGY BRASIL LTDA   Testemunhas:     _________________________________ _________________________________ Nome/CPF: Nome/CPF:    DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0BPEDRO WELLINGTON CHAVES:06579148861Digitally signed by PEDRO WELLINGTON CHAVES:06579148861 Date: 2020.11.17 08:29:02 -05\'00\'ANA CAROLINA RAMOS DE OLIVEIRA:36558121832Digitally signed by ANA CAROLINA RAMOS DE OLIVEIRA:36558121832 Date: 2020.11.17 13:01:32 -03\'00\'ANA PAULA SOEIRO DE BRITTO:09667275760Assinado de forma digital por ANA PAULA SOEIRO DE BRITTO:09667275760 Dados: 2020.11.18 10:40:21 -03\'00\'LUCIANA GIULIANI DE OLIVEIRA REIS:81364199734Assinado de forma digital por LUCIANA GIULIANI DE OLIVEIRA REIS:81364199734 Dados: 2020.11.18 14:47:49 -03\'00\'RENATO FERREIRA BORGES:01412227780Assinado de forma digital por RENATO FERREIRA BORGES:01412227780 Dados: 2020.11.18 17:51:45 -03\'00\'', 'CLÁUSULA VIGÉSIMA PRIMEIRA – FORO  É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As folhas deste Contrato são conferidas por Márcio Oliveira da Rocha, advogado do BNDES, por autorização do representante legal que o assina.  E, por estarem assim justos e contratados, firmam o presente Instrumento, redigido em 1 (uma) via de igual teor e forma, para um só efeito, juntamente com as testemunhas abaixo.  Reputa-se celebrado o presente Contrato na data em que for registrada a última assinatura dos representantes legais do BNDES.  Rio de Janeiro,      de                           de 2020.      _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES       _____________________________________________________________________ MICROCTRATEGY BRASIL LTDA   Testemunhas:     _________________________________ _________________________________ Nome/CPF: Nome/CPF:    DocuSign Envelope ID: 1033C6D1-E483-42A2-9FF3-746B1BCB2F0BPEDRO WELLINGTON CHAVES:06579148861Digitally signed by PEDRO WELLINGTON CHAVES:06579148861 Date: 2020.11.17 08:29:02 -05\'00\'ANA CAROLINA RAMOS DE OLIVEIRA:36558121832Digitally signed by ANA CAROLINA RAMOS DE OLIVEIRA:36558121832 Date: 2020.11.17 13:01:32 -03\'00\'ANA PAULA SOEIRO DE BRITTO:09667275760Assinado de forma digital por ANA PAULA SOEIRO DE BRITTO:09667275760 Dados: 2020.11.18 10:40:21 -03\'00\'LUCIANA GIULIANI DE OLIVEIRA REIS:81364199734Assinado de forma digital por LUCIANA GIULIANI DE OLIVEIRA REIS:81364199734 Dados: 2020.11.18 14:47:49 -03\'00\'RENATO FERREIRA BORGES:01412227780Assinado de forma digital por RENATO FERREIRA BORGES:01412227780 Dados: 2020.11.18 17:51:45 -03\'00\'').

% ===== END =====
