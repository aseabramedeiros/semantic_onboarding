% ===== KOA Combined Output | contract_id: contrato_ocs_043_2021 =====

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
% UFO-only grounding generated from: KOA_Contrato_OCS_043_2021_-_Rational.pl
% contract_id: contrato_ocs_043_2021

instance_of(contrato_ocs_043_2021, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(vs_data_comercio_distribuicao_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_043_2021).
plays_role(vs_data_comercio_distribuicao_ltda, hired_service_provider_role, contrato_ocs_043_2021).

clause_of(clausula_primeira_objeto, contrato_ocs_043_2021).
clause_of(clausula_segunda_vigencia, contrato_ocs_043_2021).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_043_2021).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_043_2021).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_043_2021).
clause_of(clausula_sexta_preco, contrato_ocs_043_2021).
clause_of(clausula_setima_pagamento, contrato_ocs_043_2021).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_043_2021).
clause_of(clausula_decima_garantia_contratual, contrato_ocs_043_2021).
clause_of(clausula_decima_primeira_obrigações_contratada, contrato_ocs_043_2021).
clause_of(clausula_decima_segunda_conduta_etica_contratada_bndes, contrato_ocs_043_2021).
clause_of(clausula_decima_terceira_sigilo_informações, contrato_ocs_043_2021).
clause_of(clausula_decima_quarta_obrigações_bndes, contrato_ocs_043_2021).
clause_of(clausula_decima_quinta_cessão_contrato_credito_sucessão_subcontratação, contrato_ocs_043_2021).
clause_of(clausula_decima_sexta_penalidades, contrato_ocs_043_2021).
clause_of(clausula_decima_setima_alteracoes_contratuais, contrato_ocs_043_2021).
clause_of(clausula_decima_oitava_extincao_contrato, contrato_ocs_043_2021).
clause_of(clausula_decima_nona_disposicoes_finais, contrato_ocs_043_2021).
clause_of(clausula_vigésima_foro, contrato_ocs_043_2021).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_043_2021).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, vs_data_comercio_distribuicao_ltda, provide_update_and_technical_support).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_update_and_technical_support).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, vs_data_comercio_distribuicao_ltda, communicate_intention_not_to_renew).
legal_relation_instance(clausula_segunda_vigencia, subjection, vs_data_comercio_distribuicao_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_segunda_vigencia, right_to_omission, vs_data_comercio_distribuicao_ltda, omit_communicating_intention_not_to_renew).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, vs_data_comercio_distribuicao_ltda, execute_service_according_specifications).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_service_execution_according_specifications).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, vs_data_comercio_distribuicao_ltda, execute_service_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, vs_data_comercio_distribuicao_ltda, price_reduction_due_to_non_compliance).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, stipulate_service_quality_standards).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_service_execution_according_to_standards).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_object).
legal_relation_instance(clausula_quinta_recebimento_objeto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_object_through_manager).
legal_relation_instance(clausula_quinta_recebimento_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, right_to_receive_object).
legal_relation_instance(clausula_sexta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_party).
legal_relation_instance(clausula_sexta_preco, right_to_action, vs_data_comercio_distribuicao_ltda, receive_payment).
legal_relation_instance(clausula_sexta_preco, no_right_to_action, vs_data_comercio_distribuicao_ltda, receive_indemnification).
legal_relation_instance(clausula_sexta_preco, duty_to_act, vs_data_comercio_distribuicao_ltda, bear_dimensioning_error).
legal_relation_instance(clausula_sexta_preco, subjection, vs_data_comercio_distribuicao_ltda, accept_proportional_reduction).
legal_relation_instance(clausula_sexta_preco, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, reduce_payment_proportionally).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_monthly).
legal_relation_instance(clausula_setima_pagamento, right_to_action, vs_data_comercio_distribuicao_ltda, receive_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, vs_data_comercio_distribuicao_ltda, present_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_within_10_days).
legal_relation_instance(clausula_setima_pagamento, right_to_action, vs_data_comercio_distribuicao_ltda, receive_payment_within_10_days).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, vs_data_comercio_distribuicao_ltda, send_document_digitally).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, vs_data_comercio_distribuicao_ltda, send_physical_document).
legal_relation_instance(clausula_setima_pagamento, right_to_action, vs_data_comercio_distribuicao_ltda, present_fiscal_document).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, vs_data_comercio_distribuicao_ltda, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, vs_data_comercio_distribuicao_ltda, present_information_requested_by_bndes).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, subjection, vs_data_comercio_distribuicao_ltda, negotiate_price_reduction).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_price_adjustment).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, vs_data_comercio_distribuicao_ltda, provide_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, vs_data_comercio_distribuicao_ltda, complement_or_replace_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, vs_data_comercio_distribuicao_ltda, obtain_guarantor_agreement).
legal_relation_instance(clausula_decima_garantia_contratual, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalty).
legal_relation_instance(clausula_decima_garantia_contratual, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extend_guarantee_presentation_period).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, vs_data_comercio_distribuicao_ltda, maintain_qualification_conditions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, vs_data_comercio_distribuicao_ltda, communicate_impediment_penalty).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, vs_data_comercio_distribuicao_ltda, repair_defects).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, vs_data_comercio_distribuicao_ltda, repair_damages).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, vs_data_comercio_distribuicao_ltda, pay_taxes).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, vs_data_comercio_distribuicao_ltda, provide_simples_nacional_exclusion).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, vs_data_comercio_distribuicao_ltda, allow_inspections).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, vs_data_comercio_distribuicao_ltda, obey_instructions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, vs_data_comercio_distribuicao_ltda, designate_representative).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, vs_data_comercio_distribuicao_ltda, present_dif).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_omit, vs_data_comercio_distribuicao_ltda, omit_offer_undue_advantage).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_omit, vs_data_comercio_distribuicao_ltda, omit_favoring_bndes_employee).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_omit, vs_data_comercio_distribuicao_ltda, omit_allocating_bndes_relatives).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, vs_data_comercio_distribuicao_ltda, observe_bndes_ethics_code).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, vs_data_comercio_distribuicao_ltda, remove_agents_from_contract).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, vs_data_comercio_distribuicao_ltda, take_measures_to_prevent_corruption).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, vs_data_comercio_distribuicao_ltda, adopt_sustainable_practices).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, vs_data_comercio_distribuicao_ltda, notify_bndes_of_situation).
legal_relation_instance(clausula_decima_terceira_sigilo_informações, duty_to_act, vs_data_comercio_distribuicao_ltda, comply_with_bndes_security_policy).
legal_relation_instance(clausula_decima_terceira_sigilo_informações, duty_to_omit, vs_data_comercio_distribuicao_ltda, not_access_confidential_info_without_authorization).
legal_relation_instance(clausula_decima_terceira_sigilo_informações, duty_to_act, vs_data_comercio_distribuicao_ltda, maintain_confidentiality).
legal_relation_instance(clausula_decima_terceira_sigilo_informações, duty_to_act, vs_data_comercio_distribuicao_ltda, limit_access_to_information).
legal_relation_instance(clausula_decima_terceira_sigilo_informações, duty_to_act, vs_data_comercio_distribuicao_ltda, inform_bndes_of_security_violations).
legal_relation_instance(clausula_decima_terceira_sigilo_informações, duty_to_act, vs_data_comercio_distribuicao_ltda, return_bndes_property_at_end_of_contract).
legal_relation_instance(clausula_decima_terceira_sigilo_informações, duty_to_act, vs_data_comercio_distribuicao_ltda, present_confidentiality_terms).
legal_relation_instance(clausula_decima_terceira_sigilo_informações, duty_to_act, vs_data_comercio_distribuicao_ltda, observe_confidentiality_agreement).
legal_relation_instance(clausula_decima_terceira_sigilo_informações, subjection, vs_data_comercio_distribuicao_ltda, duty_to_maintain_confidentiality_after_contract_termination).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments_to_contracted_party).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_requested_documents).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_necessary_information).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions_and_procedures).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_administrative_procedure).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_penalty).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_subcontratação, duty_to_omit, vs_data_comercio_distribuicao_ltda, omit_contract_assignment).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_subcontratação, no_right_to_action, vs_data_comercio_distribuicao_ltda, no_right_to_assign_contract).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_subcontratação, duty_to_omit, vs_data_comercio_distribuicao_ltda, omit_credit_assignment).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_subcontratação, no_right_to_action, vs_data_comercio_distribuicao_ltda, no_right_to_assign_credit).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_subcontratação, duty_to_omit, vs_data_comercio_distribuicao_ltda, omit_issuing_credit_title).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_subcontratação, no_right_to_action, vs_data_comercio_distribuicao_ltda, no_right_to_issue_credit_title).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_subcontratação, duty_to_omit, vs_data_comercio_distribuicao_ltda, omit_subcontracting).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_subcontratação, no_right_to_action, vs_data_comercio_distribuicao_ltda, no_right_to_subcontract).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_subcontratação, duty_to_omit, vs_data_comercio_distribuicao_ltda, omit_contractual_succession).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_subcontratação, no_right_to_action, vs_data_comercio_distribuicao_ltda, no_right_to_contractual_succession).
legal_relation_instance(clausula_decima_sexta_penalidades, subjection, vs_data_comercio_distribuicao_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_decima_sexta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_sexta_penalidades, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, ensure_due_process).
legal_relation_instance(clausula_decima_sexta_penalidades, right_to_action, vs_data_comercio_distribuicao_ltda, present_defense).
legal_relation_instance(clausula_decima_sexta_penalidades, right_to_action, vs_data_comercio_distribuicao_ltda, appeal_penalty).
legal_relation_instance(clausula_decima_sexta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_sexta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_debts).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalizar_alteracao_imprescindivel).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, nao_desnaturar_objeto_contrato).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, responder_danos_recusa).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alterar_contrato_acordo).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alegar_justo_motivo).
legal_relation_instance(clausula_decima_oitava_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_contract_execution).
legal_relation_instance(clausula_decima_oitava_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_for_breach).
legal_relation_instance(clausula_decima_oitava_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_notification_of_breach).
legal_relation_instance(clausula_decima_oitava_extincao_contrato, duty_to_act, vs_data_comercio_distribuicao_ltda, cure_breach).
legal_relation_instance(clausula_decima_oitava_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_nona_disposicoes_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights).
legal_relation_instance(clausula_decima_nona_disposicoes_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_strict_compliance_waived).
legal_relation_instance(clausula_decima_nona_disposicoes_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_strict_compliance_novation).
legal_relation_instance(clausula_vigésima_foro, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, establish_forum_rio_de_janeiro).
legal_relation_instance(clausula_vigésima_foro, disability, banco_nacional_de_desenvolvimento_economico_e_social_bndes, litigate_outside_rio_de_janeiro).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, vs_data_comercio_distribuicao_ltda, bear_risks_from_risk_matrix).
legal_relation_instance(clausula_nona_matriz_riscos, subjection, vs_data_comercio_distribuicao_ltda, be_subject_to_economic_financial_equilibrium_clause).

% --- Action catalog (local to this contract grounding) ---
action_type(accept_proportional_reduction).
action_label(accept_proportional_reduction, 'Accept proportional reduction').
action_type(adopt_sustainable_practices).
action_label(adopt_sustainable_practices, 'Adopt sustainable practices').
action_type(alegar_justo_motivo).
action_label(alegar_justo_motivo, 'Claim just cause').
action_type(allow_inspections).
action_label(allow_inspections, 'Allow inspections').
action_type(alterar_contrato_acordo).
action_label(alterar_contrato_acordo, 'Alter contract by agreement').
action_type(analyze_price_adjustment).
action_label(analyze_price_adjustment, 'Analyze price adjustment').
action_type(appeal_penalty).
action_label(appeal_penalty, 'Appeal penalty').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_penalty).
action_label(apply_penalty, 'Apply penalty').
action_type(be_subject_to_economic_financial_equilibrium_clause).
action_label(be_subject_to_economic_financial_equilibrium_clause, 'Be subject to Econ-Fin Equilibrium Clause').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Be subject to penalties').
action_type(bear_dimensioning_error).
action_label(bear_dimensioning_error, 'Bear dimensioning error').
action_type(bear_risks_from_risk_matrix).
action_label(bear_risks_from_risk_matrix, 'Bear risks from risk matrix').
action_type(communicate_administrative_procedure).
action_label(communicate_administrative_procedure, 'Communicate administrative procedure').
action_type(communicate_impediment_penalty).
action_label(communicate_impediment_penalty, 'Communicate impediment penalty').
action_type(communicate_instructions_and_procedures).
action_label(communicate_instructions_and_procedures, 'Communicate instructions').
action_type(communicate_intention_not_to_renew).
action_label(communicate_intention_not_to_renew, 'Communicate intention not to renew').
action_type(communicate_penalty).
action_label(communicate_penalty, 'Communicate penalty').
action_type(complement_or_replace_guarantee).
action_label(complement_or_replace_guarantee, 'Complement/replace guarantee').
action_type(comply_with_bndes_security_policy).
action_label(comply_with_bndes_security_policy, 'Comply with BNDES security policy').
action_type(cure_breach).
action_label(cure_breach, 'Cure breach').
action_type(deduct_debts).
action_label(deduct_debts, 'Deduct debts').
action_type(demand_proof_tax_regularity).
action_label(demand_proof_tax_regularity, 'Demand tax regularity proof').
action_type(demand_service_execution_according_to_standards).
action_label(demand_service_execution_according_to_standards, 'Demand service execution').
action_type(demand_strict_compliance_novation).
action_label(demand_strict_compliance_novation, 'Demand strict compliance novation').
action_type(demand_strict_compliance_waived).
action_label(demand_strict_compliance_waived, 'Demand strict compliance waived').
action_type(designate_contract_manager).
action_label(designate_contract_manager, 'Designate contract manager').
action_type(designate_representative).
action_label(designate_representative, 'Designate representative').
action_type(duty_to_maintain_confidentiality_after_contract_termination).
action_label(duty_to_maintain_confidentiality_after_contract_termination, 'Subject to confidentiality after termination').
action_type(ensure_due_process).
action_label(ensure_due_process, 'Ensure due process').
action_type(establish_forum_rio_de_janeiro).
action_label(establish_forum_rio_de_janeiro, 'Establish Rio de Janeiro as forum').
action_type(execute_service_according_specifications).
action_label(execute_service_according_specifications, 'Execute service per specifications').
action_type(execute_service_according_to_standards).
action_label(execute_service_according_to_standards, 'Execute service according to standards').
action_type(exercise_rights).
action_label(exercise_rights, 'Exercise rights anytime').
action_type(expect_service_execution_according_specifications).
action_label(expect_service_execution_according_specifications, 'Expect service execution per specs').
action_type(extend_guarantee_presentation_period).
action_label(extend_guarantee_presentation_period, 'Extend guarantee presentation period').
action_type(formalizar_alteracao_imprescindivel).
action_label(formalizar_alteracao_imprescindivel, 'Formalize necessary change').
action_type(guarantee_no_copyright_infringement).
action_label(guarantee_no_copyright_infringement, 'Guarantee no copyright infringement').
action_type(inform_bndes_of_security_violations).
action_label(inform_bndes_of_security_violations, 'Inform BNDES of security violations').
action_type(limit_access_to_information).
action_label(limit_access_to_information, 'Limit access to information').
action_type(litigate_outside_rio_de_janeiro).
action_label(litigate_outside_rio_de_janeiro, 'No litigating outside Rio de Janeiro').
action_type(maintain_confidentiality).
action_label(maintain_confidentiality, 'Maintain confidentiality').
action_type(maintain_qualification_conditions).
action_label(maintain_qualification_conditions, 'Maintain qualification').
action_type(make_payments_to_contracted_party).
action_label(make_payments_to_contracted_party, 'Make payments').
action_type(nao_desnaturar_objeto_contrato).
action_label(nao_desnaturar_objeto_contrato, 'Do not change contract nature').
action_type(negotiate_price_reduction).
action_label(negotiate_price_reduction, 'Subject to negotiate price reduction').
action_type(no_right_to_assign_contract).
action_label(no_right_to_assign_contract, 'No right to assign contract').
action_type(no_right_to_assign_credit).
action_label(no_right_to_assign_credit, 'No right to assign credit').
action_type(no_right_to_contractual_succession).
action_label(no_right_to_contractual_succession, 'No right to contractual succession').
action_type(no_right_to_issue_credit_title).
action_label(no_right_to_issue_credit_title, 'No right to issue credit title').
action_type(no_right_to_subcontract).
action_label(no_right_to_subcontract, 'No right to subcontract').
action_type(not_access_confidential_info_without_authorization).
action_label(not_access_confidential_info_without_authorization, 'Do not access confidential info without authorization').
action_type(notify_bndes_of_situation).
action_label(notify_bndes_of_situation, 'Notify BNDES of situation').
action_type(obey_instructions).
action_label(obey_instructions, 'Obey instructions').
action_type(observe_bndes_ethics_code).
action_label(observe_bndes_ethics_code, 'Observe BNDES ethics code').
action_type(observe_confidentiality_agreement).
action_label(observe_confidentiality_agreement, 'Observe confidentiality agreement').
action_type(obtain_guarantor_agreement).
action_label(obtain_guarantor_agreement, 'Obtain guarantor agreement').
action_type(omit_allocating_bndes_relatives).
action_label(omit_allocating_bndes_relatives, 'Omit allocating BNDES relatives').
action_type(omit_communicating_intention_not_to_renew).
action_label(omit_communicating_intention_not_to_renew, 'Omit communicating not to renew').
action_type(omit_contract_assignment).
action_label(omit_contract_assignment, 'Omit contract assignment').
action_type(omit_contractual_succession).
action_label(omit_contractual_succession, 'Omit contractual succession').
action_type(omit_credit_assignment).
action_label(omit_credit_assignment, 'Omit credit assignment').
action_type(omit_favoring_bndes_employee).
action_label(omit_favoring_bndes_employee, 'Omit favoring BNDES employee').
action_type(omit_issuing_credit_title).
action_label(omit_issuing_credit_title, 'Omit issuing credit title').
action_type(omit_offer_undue_advantage).
action_label(omit_offer_undue_advantage, 'Omit offering undue advantage').
action_type(omit_subcontracting).
action_label(omit_subcontracting, 'Omit subcontracting').
action_type(pay_contracted_party).
action_label(pay_contracted_party, 'Pay contracted party').
action_type(pay_monthly).
action_label(pay_monthly, 'Pay monthly').
action_type(pay_taxes).
action_label(pay_taxes, 'Pay taxes').
action_type(pay_within_10_days).
action_label(pay_within_10_days, 'Pay within 10 days').
action_type(permit_bacen_access).
action_label(permit_bacen_access, 'Permit BACEN access').
action_type(present_confidentiality_terms).
action_label(present_confidentiality_terms, 'Present confidentiality terms').
action_type(present_defense).
action_label(present_defense, 'Present defense').
action_type(present_dif).
action_label(present_dif, 'Present DIF').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(present_information_requested_by_bndes).
action_label(present_information_requested_by_bndes, 'Present information requested by BNDES').
action_type(price_reduction_due_to_non_compliance).
action_label(price_reduction_due_to_non_compliance, 'Subject to price reduction').
action_type(provide_contractual_guarantee).
action_label(provide_contractual_guarantee, 'Provide contractual guarantee').
action_type(provide_necessary_information).
action_label(provide_necessary_information, 'Provide necessary information').
action_type(provide_requested_documents).
action_label(provide_requested_documents, 'Provide requested documents').
action_type(provide_simples_nacional_exclusion).
action_label(provide_simples_nacional_exclusion, 'Provide Simples Nacional exclusion').
action_type(provide_update_and_technical_support).
action_label(provide_update_and_technical_support, 'Provide update and technical support').
action_type(receive_indemnification).
action_label(receive_indemnification, 'Receive indemnification').
action_type(receive_notification_of_breach).
action_label(receive_notification_of_breach, 'Receive breach notification').
action_type(receive_object).
action_label(receive_object, 'Receive the object').
action_type(receive_object_through_manager).
action_label(receive_object_through_manager, 'Receive object through manager').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payment_within_10_days).
action_label(receive_payment_within_10_days, 'Receive payment in 10 days').
action_type(receive_update_and_technical_support).
action_label(receive_update_and_technical_support, 'Receive update and technical support').
action_type(reduce_payment_proportionally).
action_label(reduce_payment_proportionally, 'Reduce payment proportionally').
action_type(remove_agents_from_contract).
action_label(remove_agents_from_contract, 'Remove agents from contract').
action_type(repair_damages).
action_label(repair_damages, 'Repair damages').
action_type(repair_defects).
action_label(repair_defects, 'Repair defects').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(request_proof_of_qualification).
action_label(request_proof_of_qualification, 'Request qualification proof').
action_type(responder_danos_recusa).
action_label(responder_danos_recusa, 'Liable for refusal damages').
action_type(responsible_for_security_norms).
action_label(responsible_for_security_norms, 'Responsible for security norms').
action_type(return_bndes_property_at_end_of_contract).
action_label(return_bndes_property_at_end_of_contract, 'Return BNDES property').
action_type(right_to_receive_object).
action_label(right_to_receive_object, 'Right to receive the object').
action_type(send_document_digitally).
action_label(send_document_digitally, 'Send document digitally').
action_type(send_physical_document).
action_label(send_physical_document, 'Send physical document').
action_type(stipulate_service_quality_standards).
action_label(stipulate_service_quality_standards, 'Stipulate quality standards').
action_type(subject_to_bndes_acquiescence).
action_label(subject_to_bndes_acquiescence, 'Subject to BNDES acquiescence').
action_type(suspend_contract_execution).
action_label(suspend_contract_execution, 'Suspend contract execution').
action_type(take_measures_to_prevent_corruption).
action_label(take_measures_to_prevent_corruption, 'Prevent corruption').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').
action_type(terminate_contract_for_breach).
action_label(terminate_contract_for_breach, 'Terminate contract for breach').
action_type(undertake_contractual_succession).
action_label(undertake_contractual_succession, 'Undertake contractual succession').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_043_2021).
contract_metadata(contrato_ocs_043_2021, numero_ocs, '043/2021').
contract_metadata(contrato_ocs_043_2021, numero_sap, '4400004555').
contract_metadata(contrato_ocs_043_2021, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇO').
contract_metadata(contrato_ocs_043_2021, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'VS DATA COMERCIO & DISTRIBUICAO LTDA.']).
contract_metadata(contrato_ocs_043_2021, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_043_2021, contratado, 'VS DATA COMERCIO & DISTRIBUICAO LTDA.').
contract_metadata(contrato_ocs_043_2021, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_043_2021, cnpj_contratado, '07.268.152/0001-19').
contract_metadata(contrato_ocs_043_2021, procedimento_licitatorio, 'Pregão Eletrônico nº 03/2021').
contract_metadata(contrato_ocs_043_2021, data_autorizacao, '15/01/2021').
contract_metadata_raw(contrato_ocs_043_2021, 'IP ATI/DEGAT', '12/2020', 'trecho_literal').
contract_metadata(contrato_ocs_043_2021, data_ip_ati_degat, '23/12/2020').
contract_metadata(contrato_ocs_043_2021, rubrica_orcamentaria, '3101700021').
contract_metadata(contrato_ocs_043_2021, centro_custo, 'BN00004000').
contract_metadata(contrato_ocs_043_2021, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_043_2021, regulamento, 'Regulamento de Formalização, Execução e Fiscalização dos Contratos Administrativos do Sistema BNDES').
contract_clause(contrato_ocs_043_2021, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a prestação dos serviços de atualização e suporte técnico da Suíte IBM Rational, conforme especificações constantes do Termo de Referência e da Proposta apresentada pela CONTRATADA, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_043_2021, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 24 (vinte e quatro) meses, a contar da data de sua assinatura, podendo ser prorrogado, mediante aditivo contratual, por períodos sucessivos, até o limite total de 60 (sessenta) meses.  Parágrafo Primeiro Até 90 (noventa) dias antes do término de cada período de vigência contratual, cabe ao CONTRATADO comunicar ao Gestor do Contrato, por escrito, o seu propósito de não prorrogar a vigência por um novo período, sob pena de se presumir a sua anuência em celebrar o aditivo de prorrogação.  Parágrafo Segundo Caso o CONTRATADO se recuse a celebrar aditivo contratual de prorrogação, tendo antes manifestado sua intenção de prorrogar o Contrato ou deixado de manifestar seu propósito de não prorrogar, nos termos do Parágrafo Primeiro desta Cláusula, ficará sujeito às penalidades previstas na Cláusula de Penalidades deste Contrato.').
contract_clause(contrato_ocs_043_2021, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do serviço respeitará as especificações constantes da Proposta apresentada pela CONTRATADA e do Termo de Referência, respectivamente, Anexos II e I deste Contrato.').
contract_clause(contrato_ocs_043_2021, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'O serviço contratado deverá ser executado de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados pelo BNDES, segundo as metas de nível de serviço descritas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Único O descumprimento de qualquer meta de nível de serviço pactuada acarretará a aplicação de índice de redução do preço previsto no Termo de Referência, sem prejuízo da aplicação das penalidades previstas neste Contrato, quando cabíveis.').
contract_clause(contrato_ocs_043_2021, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do Gestor, mencionado na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Termo de Referência (Anexo I deste Contrato).').
contract_clause(contrato_ocs_043_2021, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará à CONTRATADA, pela execução do objeto contratado, o valor de até R$ 567.829,92 (quinhentos e sessenta e sete mil, oitocentos e vinte e nove reais e noventa e dois centavos), conforme Proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento, e a seguinte composição:    Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro  Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização à CONTRATADA.  Parágrafo Quarto A CONTRATADA deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua Proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua Proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato.').
contract_clause(contrato_ocs_043_2021, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, mensalmente, por meio de crédito em conta bancária, em até 10 (dez) dias úteis a contar da data de apresentação do documento fiscal ou equivalente legal (como nota fiscal, fatura, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pela CONTRATADA, observado o disposto no Termo de Referência (Anexo I deste Contrato).   Parágrafo Primeiro  O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte, mediante prévia autorização do BNDES.  Parágrafo Segundo O primeiro documento fiscal ou equivalente legal terá como objeto de cobrança o período compreendido entre o dia de início da prestação dos serviços e o último dia desse mês, e os documentos fiscais ou equivalentes legais subsequentes terão como referência o período compreendido entre o primeiro e o último dia de cada mês. O último documento fiscal ou equivalente legal, por seu turno, referir-se-á ao período compreendido entre o primeiro dia do último mês da prestação dos serviços e o último dia de serviço prestado. Em todos os casos, o documento fiscal ou equivalente legal só poderá ser emitido e apresentado ao BNDES após a efetiva prestação do serviço, respeitado o disposto no Parágrafo anterior.     Parágrafo Terceiro Para toda efetivação de pagamento, a CONTRATADA deverá encaminhar o documento fiscal ou equivalente em meio digital para caixa postal eletrônica ou protocolar em sistema eletrônico próprio do BNDES, considerando as orientações do Contratante vigentes na ocasião do pagamento. No caso de emissão de documento fiscal exclusivamente em meio físico o mesmo deverá ser encaminhado ao protocolo do BNDES para devido registro de recebimento.  Parágrafo Quarto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. descrição detalhada do objeto executado e dos respectivos valores; IV. período de referência da execução do objeto; V. nome e número do CNPJ da CONTRATADA, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VI. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; VII. nome e número do banco e da agência, bem como o número da conta corrente da CONTRATADA, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; VIII. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; IX. CNPJ do tomador do serviço: 33.657.248/0001-89; X. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XI. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento, bem como o código fiscal de operações e prestações (CFOP), se for o caso; e XII. número de inscrição do contribuinte individual válido junto ao INSS (NIT ou PIS/PASEP).  Parágrafo Quinto Ao documento fiscal ou equivalente legal, deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que a CONTRATADA é optante do Simples Nacional, se for o caso;  III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado; e V. comprovante de que a CONTRATADA recolheu para o Regime Geral de Previdência Social, no mês respectivo, sobre o limite máximo do salário-de-contribuição ou em valor inferior, se for o caso.  Parágrafo Sexto Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal à CONTRATADA ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que esta providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Sétimo Os pagamentos a serem efetuados em favor da CONTRATADA estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pela CONTRATADA.  Parágrafo Oitavo Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pela CONTRATADA.  Parágrafo Nono Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível à CONTRATADA, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.').
contract_clause(contrato_ocs_043_2021, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO O BNDES e a CONTRATADA têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pelo CONTRATADO a cada período de 12 (doze) meses, sendo o primeiro contado do dia 11/02/2021, data de apresentação da proposta (Anexo II deste Contrato), e os  seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do Índice de Custo de Tecnologia da Informação - ICTI, divulgado pelo Instituto de Pesquisa Econômica Aplicada – IPEA, ou outro índice que vier a substituí-lo, sobre o preço referido na Cláusula de Preço deste Instrumento.  Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte:  I. o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado. Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar o CONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.   Parágrafo Quarto O CONTRATADO deverá solicitar o reajuste e/ou a revisão de preços até a prorrogação ou o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias da prorrogação ou  do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a assinatura do aditivo de prorrogação torne superveniente a ocorrência do fato gerador do reajuste, ou a divulgação do índice de reajuste ocorra após a prorrogação ou o encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso o CONTRATADO não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, não fará jus aos efeitos retroativos ou, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.  Parágrafo Quinto Se o processo de reajuste e/ou revisão de preços não for concluído até o vencimento do Contrato, e este for prorrogado, sua continuidade após o reequilíbrio econômico-financeiro ficará condicionada à manutenção da proposta do CONTRATADO como a condição mais vantajosa para o BNDES, podendo este: I. realizar negociação de preços junto ao CONTRATADO, de forma a viabilizar a continuidade do ajuste, quando os novos valores fixados após o reajuste e/ou a revisão de preços estiverem acima do patamar apurado no mercado; ou  II. rescindir o Contrato, mediante aviso prévio ao CONTRATADO, com antecedência de 30 (trinta) dias, quando resultar infrutífera a negociação indicada no inciso anterior.  Parágrafo Sexto Na ocorrência da hipótese prevista no inciso II do Parágrafo anterior, o CONTRATADO fará jus à integralidade dos valores apurados no processo de reajuste e/ou revisão de preços até o término do Contrato, não podendo, todavia, reclamar qualquer indenização em razão da rescisão do mesmo.', 'clausula_oitava_equilibrio_economico_financeiro_contrato').
contract_clause(contrato_ocs_043_2021, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS O BNDES e a CONTRATADA, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de  outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.   Parágrafo Primeiro O reajuste de preço aludido na Matriz de Riscos deve respeitar o disposto na
contract_clause(contrato_ocs_043_2021, clausula_decima_garantia_contratual, 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL A CONTRATADA prestará garantia contratual, no prazo de até 10 (dez) dias úteis, contados da convocação, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para a sua aceitação estipuladas nos incisos abaixo, no valor de R$ 28.391,49 (vinte e oito mil, trezentos e noventa e um reais e quarenta e nove centavos), correspondente a 5 % (cinco por cento) do valor do presente Contrato, que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais.  I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas por este; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a)  O Instrumento de Apólice de Seguro deve prever expressamente: 1. responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas à CONTRATADA; 2. vigência pelo prazo contratual; 3. prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento da CONTRATADA - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN.  a)  O Instrumento de Fiança deve prever expressamente: 1. renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; 2. vigência pelo prazo contratual; 3. prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento da CONTRATADA - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pela CONTRATADA durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Em caso de alteração do valor contratual, utilização total ou parcial da garantia pelo BNDES, ou em situações outras que impliquem em perda ou insuficiência da garantia, a CONTRATADA deverá providenciar a complementação ou substituição da garantia prestada no prazo determinado pelo BNDES ou pactuado em aditivo ou em apostilamento, observadas as condições originais para aceitação da garantia estipuladas nesta Cláusula.  Parágrafo Terceiro Nos demais casos de alteração do Contrato, sempre que o mesmo for garantido por fiança bancária ou seguro garantia, a CONTRATADA deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe à CONTRATADA obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.', 'clausula_decima_garantia_contratual').
contract_clause(contrato_ocs_043_2021, clausula_decima_primeira_obrigações_contratada, 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DA CONTRATADA', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações da CONTRATADA:  I. manter durante a vigência deste Contrato todas as condições de habilitação exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES;  II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução  IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; VIII. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; IX. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; X. apresentar, em até 10 dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; XI.  garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES,  por acusação da espécie, podendo o CONTRATADO ser instado a intervir no processo;  XII.  responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos serviços, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES; XIII.  permitir ao Banco Central do Brasil acesso a termos firmados, documentos e informações atinentes aos serviços prestados, bem como às suas dependências, nos termos do § 1º do artigo 33 da Resolução CMN nº 4.557/2017;').
contract_clause(contrato_ocs_043_2021, clausula_decima_segunda_conduta_etica_contratada_bndes, 'CLÁUSULA DÉCIMA SEGUNDA – CONDUTA ÉTICA DA CONTRATADA E DO BNDES', 'A CONTRATADA e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta em preceitos éticos e, em especial, na sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, a CONTRATADA obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar o Código de Ética do Sistema BNDES vigente ao tempo da contratação, bem como a Política de Conduta e Integridade no âmbito das licitações e contratos administrativos e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes;  e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, à CONTRATADA, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete à CONTRATADA afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto A CONTRATADA declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e Integridade no âmbito das licitações e contratos administrativos e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_043_2021, clausula_decima_terceira_sigilo_informações, 'CLÁUSULA DÉCIMA TERCEIRA – SIGILO DAS INFORMAÇÕES', 'Cabe à CONTRATADA cumprir as seguintes regras de sigilo e assegurar a aceitação e adesão às mesmas por profissionais que integrem ou venham a integrar a sua equipe na prestação do objeto deste Contrato, as quais perdurarão, inclusive, após a cessação do vínculo contratual e da prestação do serviço: I. cumprir as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES, necessárias para assegurar a integridade e o sigilo das informações;  II. não acessar informações sigilosas do BNDES, salvo quando previamente autorizado por escrito;  III. sempre que tiver acesso às informações mencionadas no Inciso anterior: a) manter sigilo dessas informações, não podendo copiá-las, reproduzi-las, retê-las ou praticar qualquer outra forma de uso que não seja imprescindível para a adequada prestação do objeto deste Contrato; b) limitar o acesso às informações aos profissionais envolvidos na prestação do serviço objeto deste Contrato, os quais deverão estar cientes da natureza sigilosa das informações e das obrigações e responsabilidades decorrentes do uso dessas informações; e c) informar imediatamente ao BNDES qualquer violação das regras de sigilo ora estabelecidas que tenha ocorrido por sua ação ou omissão, independente da existência de dolo, bem como dos profissionais envolvidos, adotando todas as orientações do BNDES para remediar a violação; IV. entregar ao BNDES, ao término da vigência deste Contrato, todo e qualquer material de propriedade deste, inclusive notas pessoais envolvendo matéria sigilosa e registro de documentos de qualquer natureza que tenham sido criados, usados ou mantidos sob seu controle ou posse, assumindo o compromisso de não utilizar qualquer informação sigilosa a que teve acesso no âmbito deste Contrato;  V. apresentar, antes do início da prestação do serviço, Termos de Confidencialidade, conforme Anexo V a este Contrato, assinados pelos profissionais que acessarão informações sigilosas, devendo referida obrigação ser também cumprida por ocasião de substituição desses profissionais; e VI. observar o disposto no Termo de Confidencialidade assinado por seus representantes legais, Anexo IV a este Contrato.').
contract_clause(contrato_ocs_043_2021, clausula_decima_quarta_obrigações_bndes, 'CLÁUSULA DÉCIMA QUARTA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis, vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos à CONTRATADA, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Alexandre Costa Ferreira Lopes, que atualmente exerce a função de coordenador de serviços da ATI/DEGAT/GPES, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução do serviço, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita à CONTRATADA;  IV. fornecer à CONTRATADA, quando solicitado ao Gestor do Contrato, cópia do Código de Ética do Sistema BNDES, da Política de Conduta e Integridade no âmbito das licitações e contratos administrativos, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; V. colocar à disposição da CONTRATADA todas as informações necessárias à perfeita execução do serviço objeto deste Contrato; e VI. comunicar à CONTRATADA, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares da CONTRATADA, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_043_2021, clausula_decima_quinta_cessão_contrato_credito_sucessão_subcontratação, 'CLÁUSULA DÉCIMA QUINTA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO', 'É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte da CONTRATADA, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro  É vedada a sucessão contratual, salvo nas hipóteses em que a CONTRATADA realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais, previstos no Edital.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É vedada a subcontratação para a execução do objeto deste Contrato.').
contract_clause(contrato_ocs_043_2021, clausula_decima_sexta_penalidades, 'CLÁUSULA DÉCIMA SEXTA – PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, a CONTRATADA ficará sujeita às seguintes penalidades: I. advertência; II. multa: a) de até 0,07% (sete centésimos por cento) por hora excedente, aplicada sobre o valor da respectiva fatura mensal, referente ao serviço de atualização e suporte técnico, no caso de ter sido ultrapassado o limite de ajuste de pagamento estabelecido no item 5.7 do Termo de Referência;  b) de até 10% (dez por cento), apurada de acordo com a gravidade da infração, incidindo sobre o valor global do Contrato, em razão do descumprimento de outras obrigações contratuais não abrangidas na alínea “a” ; e  III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades indicadas nesta Cláusula somente poderão ser aplicadas após procedimento administrativo, e desde que assegurados o contraditório e a ampla defesa, facultada à CONTRATADA a defesa prévia, no prazo de 10 (dez) dias úteis.  Parágrafo Segundo Contra a decisão de aplicação de penalidade, a CONTRATADA poderá interpor o recurso cabível, na forma e no prazo previstos no Regulamento de Formalização, Execução e Fiscalização de Contratos Administrativos do Sistema BNDES.  Parágrafo Terceiro A imposição de sanção prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto A multa prevista nesta Cláusula poderá ser aplicada juntamente com as demais penalidades.      Parágrafo Quinto O total das multas aplicadas não poderá exceder o montante de 30% (trinta por cento) do valor global do Contrato.  Parágrafo Sexto A multa aplicada à CONTRATADA e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ela devidos, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sétimo No caso de uso indevido de informações sigilosas, observar-se-ão, no que couber, os termos da Lei nº 12.527/2011 e do Decreto nº 7.724/2012.  Parágrafo Oitavo No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Nono A sanção prevista no Inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_043_2021, clausula_decima_setima_alteracoes_contratuais, 'CLÁUSULA DÉCIMA SÉTIMA – ALTERAÇÕES CONTRATUAIS', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que: I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução,  conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.   Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento e os pequenos ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato, que poderão ser formalizados por meio epistolar.').
contract_clause(contrato_ocs_043_2021, clausula_decima_oitava_extincao_contrato, 'CLÁUSULA DÉCIMA OITAVA – EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, convencionando-se, ainda, que é cabível a sua resolução: I. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; III. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo; IV. quando for decretada a falência da CONTRATADA; V. caso a CONTRATADA perca uma das condições de habilitação exigidas quando da contratação; VI. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VII. caso a CONTRATADA seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  VIII. em função da suspensão do direito de a CONTRATADA licitar ou contratar com o BNDES; IX. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei n.º 12.846/2013, cometido pela CONTRATADA no processo  de contratação ou por ocasião da execução contratual; X. em razão [da dissolução da CONTRATADA; e XI. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato e oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_043_2021, clausula_decima_nona_disposicoes_finais, 'CLÁUSULA DÉCIMA NONA – DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram este Contrato, o Termo de Referência, a Proposta da CONTRATADA, a Matriz de Riscos, e os Termos de Confidencialidade, respectivamente, Anexos I, II, III e IV ao presente Instrumento, no que com este não colidir, bem como com as disposições legais aplicáveis, observando-se que, ocorrendo conflitos de interpretação entre as disposições contratuais e de seus anexos, prevalecerá o disposto no Contrato e na legislação em vigor.  Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_043_2021, clausula_vigésima_foro, 'CLÁUSULA VIGÉSIMA – FORO', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As folhas deste Contrato são rubricadas por Lara Godoy dos S. F. Rodrigues, advogada do BNDES, apenas para a conferência de sua redação, por autorização do representante legal que o assina.   E, por estarem assim justos e contratados, firmam o presente Instrumento, redigido em 1 (uma) via, juntamente com as testemunhas abaixo.  Reputa-se celebrado o presente Contrato na data em que for registrada a última assinatura dos representantes legais do BNDES.    _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES     _____________________________________________________________________ VS DATA COMERCIO & DISTRIBUICAO LTDA.  Testemunhas:   _________________________________ _________________________________ Nome/CPF: Nome/CPF:   JULIO EDUARDO COSTA SANTOS:08906360959Assinado de forma digital por JULIO EDUARDO COSTA SANTOS:08906360959 Dados: 2021.03.23 15:46:06 -03\'00\'ANA PAULA SOEIRO DE BRITTO:09667275760Assinado de forma digital por ANA PAULA SOEIRO DE BRITTO:09667275760 Dados: 2021.03.23 16:46:43 -03\'00\'MARCIO OLIVEIRA DA ROCHA:07635921703Assinado de forma digital por MARCIO OLIVEIRA DA ROCHA:07635921703 Dados: 2021.03.23 17:05:44 -03\'00\'LUCIANA GIULIANI DE OLIVEIRA REIS:81364199734Assinado de forma digital por LUCIANA GIULIANI DE OLIVEIRA REIS:81364199734 Dados: 2021.03.25 16:50:54 -03\'00\'FERNANDO PASSERI LAVRADO:00486757765Assinado de forma digital por FERNANDO PASSERI LAVRADO:00486757765 Dados: 2021.03.25 17:25:32 -03\'00\'').

% ===== END =====
