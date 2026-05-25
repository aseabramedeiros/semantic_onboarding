% ===== KOA Combined Output | contract_id: contrato_ocs_200_2020 =====

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
% UFO-only grounding generated from: KOA_Contrato_OCS_200_2020_-_ESEC.pl
% contract_id: contrato_ocs_200_2020

instance_of(contrato_ocs_200_2020, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(esec_tecnologia_em_seguranca_de_dados_s_a, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_200_2020).
plays_role(esec_tecnologia_em_seguranca_de_dados_s_a, hired_service_provider_role, contrato_ocs_200_2020).

clause_of(clausula_primeira_objeto, contrato_ocs_200_2020).
clause_of(clausula_segunda_vigencia, contrato_ocs_200_2020).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_200_2020).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_200_2020).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_200_2020).
clause_of(clausula_sexta_preco, contrato_ocs_200_2020).
clause_of(clausula_setima_pagamento, contrato_ocs_200_2020).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_200_2020).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_200_2020).
clause_of(clausula_decima_obrigacoes_contratada, contrato_ocs_200_2020).
clause_of(clausula_decima_primeira_conduta_etica, contrato_ocs_200_2020).
clause_of(clausula_decima_segunda_sigilo_informacoes, contrato_ocs_200_2020).
clause_of(clausula_decima_terceira_obrigacoes_bndes, contrato_ocs_200_2020).
clause_of(clausula_decima_quarta_cessao_contrato_subcontratacao, contrato_ocs_200_2020).
clause_of(clausula_decima_quinta_penalidades, contrato_ocs_200_2020).
clause_of(clausula_decima_sexta_alteracoes_contratuais, contrato_ocs_200_2020).
clause_of(clausula_decima_setima_extincao_contrato, contrato_ocs_200_2020).
clause_of(clausula_decima_oitava_disposicoes_finais, contrato_ocs_200_2020).
clause_of(clausula_decima_nona_foro, contrato_ocs_200_2020).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, provide_technical_support).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_technical_support).
legal_relation_instance(clausula_segunda_vigencia, subjection, esec_tecnologia_em_seguranca_de_dados_s_a, subject_to_penalties_for_refusal_to_extend).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, communicate_intent_not_to_extend).
legal_relation_instance(clausula_segunda_vigencia, right_to_omission, esec_tecnologia_em_seguranca_de_dados_s_a, omit_communicating_intent_not_to_extend).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, execute_service_according_to_specs).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, esec_tecnologia_em_seguranca_de_dados_s_a, execute_service).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, execute_service_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_service_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_price_reduction).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, esec_tecnologia_em_seguranca_de_dados_s_a, be_subject_to_price_reduction).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_quinta_recebimento_objeto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_sexta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_party).
legal_relation_instance(clausula_sexta_preco, right_to_action, esec_tecnologia_em_seguranca_de_dados_s_a, receive_payment).
legal_relation_instance(clausula_sexta_preco, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, bear_dimensional_errors).
legal_relation_instance(clausula_sexta_preco, no_right_to_action, esec_tecnologia_em_seguranca_de_dados_s_a, demand_indemnification).
legal_relation_instance(clausula_sexta_preco, subjection, esec_tecnologia_em_seguranca_de_dados_s_a, accept_proportional_reduction).
legal_relation_instance(clausula_sexta_preco, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, partially_execute_and_receive).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, efetuar_pagamento).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, apresentar_documento_fiscal).
legal_relation_instance(clausula_setima_pagamento, subjection, esec_tecnologia_em_seguranca_de_dados_s_a, subject_to_tax_withholding).
legal_relation_instance(clausula_setima_pagamento, right_to_action, esec_tecnologia_em_seguranca_de_dados_s_a, receive_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, encaminhar_documento_digital).
legal_relation_instance(clausula_setima_pagamento, right_to_action, esec_tecnologia_em_seguranca_de_dados_s_a, receive_interest).
legal_relation_instance(clausula_setima_pagamento, permission_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_payment_without_contracted_fault).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, esec_tecnologia_em_seguranca_de_dados_s_a, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, esec_tecnologia_em_seguranca_de_dados_s_a, request_price_adjustment).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, submit_documentation_for_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, provide_requested_information).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, request_reajustment).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_request).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_deadline).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, rescind_contract).
legal_relation_instance(clausula_nona_matriz_riscos, no_right_to_action, esec_tecnologia_em_seguranca_de_dados_s_a, celebrate_additives_for_allocated_events).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, allocate_risk_to_party_with_capacity).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, allocate_risk_to_party_with_capacity).
legal_relation_instance(clausula_nona_matriz_riscos, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, respect_price_readjustment).
legal_relation_instance(clausula_nona_matriz_riscos, subjection, esec_tecnologia_em_seguranca_de_dados_s_a, respect_price_readjustment).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, notify_bndes_of_risks).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_omit, esec_tecnologia_em_seguranca_de_dados_s_a, not_reverse_engineer_application).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, maintain_confidentiality_note).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, ensure_confidentiality_awareness).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, require_employee_confidentiality).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, deliver_documentation_to_bndes).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, observe_confidentiality_norms).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, adopt_security_measures).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, observe_security_norms_at_bndes).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, comply_with_laws).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_omit, esec_tecnologia_em_seguranca_de_dados_s_a, not_offer_undue_advantage).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, take_measures_to_prevent_corruption).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_omit, esec_tecnologia_em_seguranca_de_dados_s_a, prevent_favoritism).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_omit, esec_tecnologia_em_seguranca_de_dados_s_a, not_allocate_family_members).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, observe_code_of_ethics).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, adopt_good_practices).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, remove_agents_implying_impediments).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, communicate_fact_to_bndes).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, comply_with_bndes_information_security_policy).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_omit, esec_tecnologia_em_seguranca_de_dados_s_a, not_access_confidential_information_without_authorization).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, maintain_confidentiality_of_information).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, limit_access_to_information).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, inform_bndes_of_confidentiality_breaches).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, return_bndes_property).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_omit, esec_tecnologia_em_seguranca_de_dados_s_a, not_use_confidential_information_after_termination).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, present_confidentiality_agreements).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, observe_confidentiality_agreement).
legal_relation_instance(clausula_decima_terceira_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments_to_contratada).
legal_relation_instance(clausula_decima_terceira_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contrato_manager).
legal_relation_instance(clausula_decima_terceira_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_substitute_contract_manager).
legal_relation_instance(clausula_decima_terceira_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_code_of_ethics).
legal_relation_instance(clausula_decima_terceira_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_necessary_information).
legal_relation_instance(clausula_decima_terceira_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions).
legal_relation_instance(clausula_decima_terceira_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_administrative_procedure).
legal_relation_instance(clausula_decima_terceira_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_penalty).
legal_relation_instance(clausula_decima_terceira_obrigacoes_bndes, subjection, esec_tecnologia_em_seguranca_de_dados_s_a, be_subject_to_penalty).
legal_relation_instance(clausula_decima_terceira_obrigacoes_bndes, right_to_action, esec_tecnologia_em_seguranca_de_dados_s_a, receive_payments_from_bndes).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_subcontratacao, duty_to_omit, esec_tecnologia_em_seguranca_de_dados_s_a, omit_contract_cession).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_subcontratacao, no_right_to_action, esec_tecnologia_em_seguranca_de_dados_s_a, no_right_contract_cession).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_subcontratacao, duty_to_omit, esec_tecnologia_em_seguranca_de_dados_s_a, omit_credit_cession).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_subcontratacao, no_right_to_action, esec_tecnologia_em_seguranca_de_dados_s_a, no_right_credit_cession).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_subcontratacao, duty_to_omit, esec_tecnologia_em_seguranca_de_dados_s_a, omit_issuing_credit_title).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_subcontratacao, no_right_to_action, esec_tecnologia_em_seguranca_de_dados_s_a, no_right_issuing_credit_title).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_subcontratacao, duty_to_omit, esec_tecnologia_em_seguranca_de_dados_s_a, omit_subcontracting).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_subcontratacao, no_right_to_action, esec_tecnologia_em_seguranca_de_dados_s_a, no_right_subcontracting).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_subcontratacao, duty_to_omit, esec_tecnologia_em_seguranca_de_dados_s_a, omit_contract_succession).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_subcontratacao, no_right_to_action, esec_tecnologia_em_seguranca_de_dados_s_a, no_right_contract_succession).
legal_relation_instance(clausula_decima_quinta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_quinta_penalidades, subjection, esec_tecnologia_em_seguranca_de_dados_s_a, be_subject_to_penalties).
legal_relation_instance(clausula_decima_quinta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_credits).
legal_relation_instance(clausula_decima_quinta_penalidades, subjection, esec_tecnologia_em_seguranca_de_dados_s_a, have_credits_deducted).
legal_relation_instance(clausula_decima_quinta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_suspension).
legal_relation_instance(clausula_decima_quinta_penalidades, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_quinta_penalidades, duty_to_act, esec_tecnologia_em_seguranca_de_dados_s_a, comply_with_contract).
legal_relation_instance(clausula_decima_sexta_alteracoes_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, agree_to_contract_changes).
legal_relation_instance(clausula_decima_sexta_alteracoes_contratuais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, change_contract_to_denature_it).
legal_relation_instance(clausula_decima_sexta_alteracoes_contratuais, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_changing_contract_to_denature_it).
legal_relation_instance(clausula_decima_sexta_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, agree_to_essential_contract_changes).
legal_relation_instance(clausula_decima_sexta_alteracoes_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, be_liable_for_damages_caused_by_refusal).
legal_relation_instance(clausula_decima_sexta_alteracoes_contratuais, no_right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, must_agree_to_essential_contract_changes).
legal_relation_instance(clausula_decima_sexta_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, compensate_for_unjustified_refusal_to_change).
legal_relation_instance(clausula_decima_setima_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_other_party).
legal_relation_instance(clausula_decima_setima_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_notification).
legal_relation_instance(clausula_decima_setima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_contract_execution).
legal_relation_instance(clausula_decima_setima_extincao_contrato, subjection, esec_tecnologia_em_seguranca_de_dados_s_a, be_subject_to_suspension).
legal_relation_instance(clausula_decima_setima_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_opportunity_for_defense).
legal_relation_instance(clausula_decima_setima_extincao_contrato, right_to_action, esec_tecnologia_em_seguranca_de_dados_s_a, offer_defense).
legal_relation_instance(clausula_decima_oitava_disposicoes_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, claim_waiver_from_omission).
legal_relation_instance(clausula_decima_oitava_disposicoes_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, claim_novation_from_omission).
legal_relation_instance(clausula_decima_oitava_disposicoes_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_contractual_rights).
legal_relation_instance(clausula_decima_oitava_disposicoes_finais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, comply_with_contract_terms).
legal_relation_instance(clausula_decima_nona_foro, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, establish_forum).
legal_relation_instance(clausula_decima_nona_foro, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, litigate_in_other_forum).

% --- Action catalog (local to this contract grounding) ---
action_type(accept_bndes_inspection).
action_label(accept_bndes_inspection, 'Accept BNDES inspection').
action_type(accept_proportional_reduction).
action_label(accept_proportional_reduction, 'Accept proportional reduction').
action_type(adopt_good_practices).
action_label(adopt_good_practices, 'Adopt good practices').
action_type(adopt_security_measures).
action_label(adopt_security_measures, 'Adopt security measures').
action_type(agree_to_contract_changes).
action_label(agree_to_contract_changes, 'Agree to contract changes').
action_type(agree_to_essential_contract_changes).
action_label(agree_to_essential_contract_changes, 'Agree to essential changes').
action_type(allocate_risk_to_party_with_capacity).
action_label(allocate_risk_to_party_with_capacity, 'Allocate risk appropriately').
action_type(analyze_request).
action_label(analyze_request, 'Analyze request').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_price_reduction).
action_label(apply_price_reduction, 'Apply price reduction').
action_type(apply_suspension).
action_label(apply_suspension, 'Apply suspension').
action_type(apresentar_documento_fiscal).
action_label(apresentar_documento_fiscal, 'Present invoice').
action_type(be_liable_for_damages_caused_by_refusal).
action_label(be_liable_for_damages_caused_by_refusal, 'Liable for damages').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Be subject to penalties').
action_type(be_subject_to_penalty).
action_label(be_subject_to_penalty, 'Subject to penalty').
action_type(be_subject_to_price_reduction).
action_label(be_subject_to_price_reduction, 'Be subject to price reduction').
action_type(be_subject_to_suspension).
action_label(be_subject_to_suspension, 'Be subject to suspension').
action_type(bear_dimensional_errors).
action_label(bear_dimensional_errors, 'Bear quantity errors').
action_type(celebrate_additives_for_allocated_events).
action_label(celebrate_additives_for_allocated_events, 'Not allowed to make additives').
action_type(change_contract_to_denature_it).
action_label(change_contract_to_denature_it, 'Change contract to denature it').
action_type(claim_novation_from_omission).
action_label(claim_novation_from_omission, 'Claim novation due to omission').
action_type(claim_waiver_from_omission).
action_label(claim_waiver_from_omission, 'Claim waiver due to omission').
action_type(communicate_administrative_procedure).
action_label(communicate_administrative_procedure, 'Communicate procedure').
action_type(communicate_fact_to_bndes).
action_label(communicate_fact_to_bndes, 'Communicate fact to BNDES').
action_type(communicate_instructions).
action_label(communicate_instructions, 'Communicate instructions').
action_type(communicate_intent_not_to_extend).
action_label(communicate_intent_not_to_extend, 'Communicate intent not to extend').
action_type(communicate_penalty).
action_label(communicate_penalty, 'Communicate penalty').
action_type(compensate_for_unjustified_refusal_to_change).
action_label(compensate_for_unjustified_refusal_to_change, 'Compensate for unjustified refusal').
action_type(comply_with_bndes_information_security_policy).
action_label(comply_with_bndes_information_security_policy, 'Comply with BNDES security policy').
action_type(comply_with_contract).
action_label(comply_with_contract, 'Comply with contract').
action_type(comply_with_contract_terms).
action_label(comply_with_contract_terms, 'Comply with contract terms').
action_type(comply_with_laws).
action_label(comply_with_laws, 'Comply with laws').
action_type(deduct_credits).
action_label(deduct_credits, 'Deduct credits').
action_type(deliver_documentation_to_bndes).
action_label(deliver_documentation_to_bndes, 'Deliver documentation to BNDES').
action_type(demand_indemnification).
action_label(demand_indemnification, 'Demand indemnification').
action_type(designate_contrato_manager).
action_label(designate_contrato_manager, 'Designate contract manager').
action_type(designate_substitute_contract_manager).
action_label(designate_substitute_contract_manager, 'Designate substitute manager').
action_type(efetuar_pagamento).
action_label(efetuar_pagamento, 'Make payment').
action_type(effect_object_receipt).
action_label(effect_object_receipt, 'Effect object receipt').
action_type(encaminhar_documento_digital).
action_label(encaminhar_documento_digital, 'Send digital invoice').
action_type(ensure_confidentiality_awareness).
action_label(ensure_confidentiality_awareness, 'Ensure confidentiality awareness').
action_type(establish_forum).
action_label(establish_forum, 'Establish forum').
action_type(execute_service).
action_label(execute_service, 'Execute service').
action_type(execute_service_according_to_specs).
action_label(execute_service_according_to_specs, 'Execute service as specified').
action_type(execute_service_according_to_standards).
action_label(execute_service_according_to_standards, 'Execute service to standards').
action_type(exercise_contractual_rights).
action_label(exercise_contractual_rights, 'Exercise contractual rights').
action_type(grant_acquiescence_to_succession).
action_label(grant_acquiescence_to_succession, 'Grant acquiescence to succession').
action_type(guarantee_solution_updates).
action_label(guarantee_solution_updates, 'Guarantee solution updates').
action_type(have_credits_deducted).
action_label(have_credits_deducted, 'Have credits deducted').
action_type(inform_bndes_of_confidentiality_breaches).
action_label(inform_bndes_of_confidentiality_breaches, 'Inform BNDES of breaches').
action_type(limit_access_to_information).
action_label(limit_access_to_information, 'Limit access to information').
action_type(litigate_in_other_forum).
action_label(litigate_in_other_forum, 'Litigate in other forum').
action_type(maintain_confidentiality_note).
action_label(maintain_confidentiality_note, 'Maintain confidentiality note').
action_type(maintain_confidentiality_of_information).
action_label(maintain_confidentiality_of_information, 'Maintain confidentiality').
action_type(make_payments_to_contratada).
action_label(make_payments_to_contratada, 'Make payments').
action_type(must_agree_to_essential_contract_changes).
action_label(must_agree_to_essential_contract_changes, 'Must agree to essential changes').
action_type(no_right_contract_cession).
action_label(no_right_contract_cession, 'No right to contract cession').
action_type(no_right_contract_succession).
action_label(no_right_contract_succession, 'No right to contract succession').
action_type(no_right_credit_cession).
action_label(no_right_credit_cession, 'No right to credit cession').
action_type(no_right_issuing_credit_title).
action_label(no_right_issuing_credit_title, 'No right to issue credit title').
action_type(no_right_subcontracting).
action_label(no_right_subcontracting, 'No right to subcontracting').
action_type(not_access_confidential_information_without_authorization).
action_label(not_access_confidential_information_without_authorization, 'Do not access confidential info without authorization').
action_type(not_allocate_family_members).
action_label(not_allocate_family_members, 'Not allocate family members').
action_type(not_offer_undue_advantage).
action_label(not_offer_undue_advantage, 'Not offer undue advantage').
action_type(not_reverse_engineer_application).
action_label(not_reverse_engineer_application, 'Not reverse engineer application').
action_type(not_use_confidential_information_after_termination).
action_label(not_use_confidential_information_after_termination, 'Not use confidential info after termination').
action_type(notify_bndes_of_risks).
action_label(notify_bndes_of_risks, 'Notify BNDES of risks').
action_type(notify_other_party).
action_label(notify_other_party, 'Notify other party').
action_type(observe_code_of_ethics).
action_label(observe_code_of_ethics, 'Observe code of ethics').
action_type(observe_confidentiality_agreement).
action_label(observe_confidentiality_agreement, 'Observe confidentiality agreement').
action_type(observe_confidentiality_norms).
action_label(observe_confidentiality_norms, 'Observe confidentiality norms').
action_type(observe_security_norms_at_bndes).
action_label(observe_security_norms_at_bndes, 'Observe security norms at BNDES').
action_type(offer_defense).
action_label(offer_defense, 'Offer defense').
action_type(omit_changing_contract_to_denature_it).
action_label(omit_changing_contract_to_denature_it, 'Omit contract denaturing change').
action_type(omit_communicating_intent_not_to_extend).
action_label(omit_communicating_intent_not_to_extend, 'Omit communicating intent not to extend').
action_type(omit_contract_cession).
action_label(omit_contract_cession, 'Omit contract cession').
action_type(omit_contract_succession).
action_label(omit_contract_succession, 'Omit contract succession').
action_type(omit_credit_cession).
action_label(omit_credit_cession, 'Omit credit cession').
action_type(omit_issuing_credit_title).
action_label(omit_issuing_credit_title, 'Omit issuing credit title').
action_type(omit_payment_without_contracted_fault).
action_label(omit_payment_without_contracted_fault, 'Omit payment w/o fault').
action_type(omit_subcontracting).
action_label(omit_subcontracting, 'Omit subcontracting').
action_type(partially_execute_and_receive).
action_label(partially_execute_and_receive, 'Partially execute and receive').
action_type(pay_contracted_party).
action_label(pay_contracted_party, 'Pay the contracted party').
action_type(pay_for_damages_by_employees).
action_label(pay_for_damages_by_employees, 'Pay for damages by employees').
action_type(permit_central_bank_access).
action_label(permit_central_bank_access, 'Permit central bank access').
action_type(present_confidentiality_agreements).
action_label(present_confidentiality_agreements, 'Present confidentiality agreements').
action_type(prevent_favoritism).
action_label(prevent_favoritism, 'Prevent favoritism').
action_type(provide_code_of_ethics).
action_label(provide_code_of_ethics, 'Provide code of ethics').
action_type(provide_necessary_information).
action_label(provide_necessary_information, 'Provide necessary info').
action_type(provide_opportunity_for_defense).
action_label(provide_opportunity_for_defense, 'Provide opportunity for defense').
action_type(provide_requested_information).
action_label(provide_requested_information, 'Provide requested information').
action_type(provide_technical_support).
action_label(provide_technical_support, 'Provide technical support').
action_type(receive_interest).
action_label(receive_interest, 'Receive interest on late payment').
action_type(receive_notification).
action_label(receive_notification, 'Receive notification').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payments_from_bndes).
action_label(receive_payments_from_bndes, 'Receive payments').
action_type(receive_service_according_to_standards).
action_label(receive_service_according_to_standards, 'Receive service to standards').
action_type(receive_technical_support).
action_label(receive_technical_support, 'Receive technical support').
action_type(remove_agents_implying_impediments).
action_label(remove_agents_implying_impediments, 'Remove agents implying impediments').
action_type(repair_damages).
action_label(repair_damages, 'Repair damages').
action_type(request_code_of_ethics).
action_label(request_code_of_ethics, 'Request code of ethics').
action_type(request_necessary_information).
action_label(request_necessary_information, 'Request necessary information').
action_type(request_price_adjustment).
action_label(request_price_adjustment, 'Request price adjustment').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(request_reajustment).
action_label(request_reajustment, 'Request readjustment').
action_type(require_employee_confidentiality).
action_label(require_employee_confidentiality, 'Require employee confidentiality').
action_type(rescind_contract).
action_label(rescind_contract, 'Rescind contract').
action_type(respect_price_readjustment).
action_label(respect_price_readjustment, 'Respect price readjustment rules').
action_type(responsible_for_charges).
action_label(responsible_for_charges, 'Responsible for charges').
action_type(return_bndes_property).
action_label(return_bndes_property, 'Return BNDES property').
action_type(subject_to_penalties_for_refusal_to_extend).
action_label(subject_to_penalties_for_refusal_to_extend, 'Subject to penalties for refusal to extend').
action_type(subject_to_tax_withholding).
action_label(subject_to_tax_withholding, 'Subject to tax withholding').
action_type(submit_documentation_for_revision).
action_label(submit_documentation_for_revision, 'Submit documentation for revision').
action_type(suspend_contract_execution).
action_label(suspend_contract_execution, 'Suspend contract execution').
action_type(suspend_deadline).
action_label(suspend_deadline, 'Suspend deadline').
action_type(take_measures_to_prevent_corruption).
action_label(take_measures_to_prevent_corruption, 'Prevent corruption').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_200_2020).
contract_metadata(contrato_ocs_200_2020, numero_ocs, '200/2020').
contract_metadata(contrato_ocs_200_2020, numero_sap, '4400004338').
contract_metadata(contrato_ocs_200_2020, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇO').
contract_metadata(contrato_ocs_200_2020, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'ESEC TECNOLOGIA EM SEGURANÇA DE DADOS S.A']).
contract_metadata(contrato_ocs_200_2020, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_200_2020, contratado, 'ESEC TECNOLOGIA EM SEGURANÇA DE DADOS S.A').
contract_metadata(contrato_ocs_200_2020, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_200_2020, cnpj_contratado, '03.242.841/0001-01').
contract_metadata(contrato_ocs_200_2020, procedimento_licitatorio, 'Inexigibilidade de Licitação nº 040/2020').
contract_metadata(contrato_ocs_200_2020, data_autorizacao, '14/09/2020').
contract_metadata_raw(contrato_ocs_200_2020, 'ip_ati_desis4', '02/2020', 'trecho_literal').
contract_metadata(contrato_ocs_200_2020, rubrica_orcamentaria, '3101700021').
contract_metadata(contrato_ocs_200_2020, centro_custo, 'BN00004000').
contract_metadata(contrato_ocs_200_2020, regulamento, 'Regulamento de Formalização, Execução e Fiscalização dos Contratos Administrativos do Sistema BNDES').
contract_metadata(contrato_ocs_200_2020, lei_aplicavel, 'Lei nº 13.303/2016').
contract_clause(contrato_ocs_200_2020, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto o provimento do serviço especializado de suporte técnico e manutenção da biblioteca de software EVO-SDK e o aplicativo SDK-DESKTOP, doravante denominados SOLUÇÃO, conforme condições constantes das Especificações Técnicas e da Proposta apresentada pela CONTRATADA, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_200_2020, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 24 (vinte e quatro) meses, a contar da data de sua assinatura, podendo ser prorrogado, mediante aditivo contratual, por períodos sucessivos, até o limite total de 60 (sessenta) meses.  Parágrafo Primeiro Até 90 (noventa) dias antes do término de cada período de vigência contratual, cabe à CONTRATADA comunicar ao Gestor do Contrato, por escrito, o seu propósito de não 2 prorrogar a vigência por um novo período, sob pena de se presumir a sua anuência em celebrar o aditivo de prorrogação.  Parágrafo Segundo Caso a CONTRATADA se recuse a celebrar aditivo contratual de prorrogação, tendo antes manifestado sua intenção de prorrogar o Contrato ou deixado de manifestar seu propósito de não prorrogar, nos termos do Parágrafo Primeiro desta Cláusula, ficará sujeita às penalidades previstas na Cláusula de Penalidades deste Contrato.').
contract_clause(contrato_ocs_200_2020, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do serviço respeitará as especificações constantes da Proposta apresentada pela CONTRATADA e das Especificações Técnicas, respectivamente, Anexos II e I deste Contrato.').
contract_clause(contrato_ocs_200_2020, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'O serviço contratado deverá ser executado de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados pelo BNDES, segundo as metas de nível de serviço descritas nas Especificações Técnicas (Anexo I deste Contrato).  Parágrafo Único O descumprimento de qualquer meta de nível de serviço pactuada acarretará a aplicação de índice de redução do preço previsto nas Especificações Técnicas, sem prejuízo da aplicação das penalidades previstas neste Contrato, quando cabíveis.').
contract_clause(contrato_ocs_200_2020, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do Gestor mencionado na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto nas Especificações Técnicas (Anexo I deste Contrato).').
contract_clause(contrato_ocs_200_2020, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará à CONTRATADA, pela execução do objeto contratado, o valor de R$ 39.000,00 (trinta e nove mil reais), conforme Proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento, e a seguinte composição:     3 Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização à CONTRATADA.  Parágrafo Quarto A CONTRATADA deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua Proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua Proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato.').
contract_clause(contrato_ocs_200_2020, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, mensalmente, por meio de crédito em conta bancária, em até 10 (dez) dias úteis a contar da data de apresentação do documento fiscal ou equivalente legal (como nota fiscal, fatura, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pela CONTRATADA, observado o disposto no Termo de Referência (Anexo I deste Contrato).   Parágrafo Primeiro  O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte, mediante prévia autorização do BNDES. Parágrafo Segundo O primeiro documento fiscal ou equivalente legal terá como objeto de cobrança o período compreendido entre o dia de início da prestação dos serviços e o último dia desse mês, e os documentos fiscais ou equivalentes legais subsequentes terão como referência o período compreendido entre o primeiro e o último dia de cada mês. O último documento fiscal ou equivalente legal, por seu turno, referir-se-á ao período 4 compreendido entre o primeiro dia do último mês da prestação dos serviços e o último dia de serviço prestado. Em todos os casos, o documento fiscal ou equivalente legal só poderá ser emitido e apresentado ao BNDES após a efetiva prestação do serviço, respeitado o disposto no Parágrafo anterior.  Parágrafo Terceiro Para toda efetivação de pagamento, o Contratado deverá encaminhar o documento fiscal ou equivalente em meio digital para caixa postal eletrônica ou protocolar em sistema eletrônico próprio do BNDES, considerando as orientações do Contratante vigentes na ocasião do pagamento. No caso de emissão de documento fiscal exclusivamente em meio físico o mesmo deverá ser encaminhado ao protocolo do BNDES para devido registro de recebimento.  Parágrafo Quarto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. descrição detalhada do objeto executado e dos respectivos valores; IV. período de referência da execução do objeto; V. nome e número do CNPJ da CONTRATADA, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VI. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; VII. nome e número do banco e da agência, bem como o número da conta corrente da CONTRATADA, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; VIII. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; IX. CNPJ do tomador do serviço: 33.657.248/0001-89; X. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XI. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento, bem como o código fiscal de operações e prestações (CFOP), se for o caso; e XII. número de inscrição do contribuinte individual válido junto ao INSS (NIT ou PIS/PASEP).  Parágrafo Quinto Ao documento fiscal ou equivalente legal, deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; 5 II. comprovante de que a CONTRATADA é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado; e V. comprovante de que a CONTRATADA recolheu para o Regime Geral de Previdência Social, no mês respectivo, sobre o limite máximo do salário-de-contribuição ou em valor inferior, se for o caso.  Parágrafo Sexto Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal à CONTRATADA ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que esta providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Sétimo Os pagamentos a serem efetuados em favor da CONTRATADA estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pela CONTRATADA.  Parágrafo Oitavo Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pela CONTRATADA.  Parágrafo Nono Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível à CONTRATADA, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação..').
contract_clause(contrato_ocs_200_2020, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO', 'O BNDES e a CONTRATADA têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pela CONTRATADA a cada período de 12 (doze) meses, sendo o primeiro contado do dia 11/08/2020, data da apresentação da Proposta (Anexo II deste Contrato), e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do Índice de 6 Custo da Tecnologia da Informação – ICTI, divulgado pelo Instituto de Pesquisa Econômica Aplicada – IPEA acumulado, sobre o preço referido na Cláusula de Preço deste Instrumento.   Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação da CONTRATADA, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado à CONTRATADA nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. a CONTRATADA deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da Proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, a CONTRATADA deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da Proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar a CONTRATADA para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na Proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo à CONTRATADA apresentar as informações solicitadas pelo BNDES.   Parágrafo Quarto A CONTRATADA deverá solicitar o reajuste e/ou a revisão de preços até a prorrogação ou o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias da prorrogação ou do encerramento do Contrato, a CONTRATADA terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; 7 II. caso a assinatura do aditivo de prorrogação torne superveniente a ocorrência do fato gerador do reajuste, ou a divulgação do índice de reajuste ocorra após a prorrogação ou o encerramento do Contrato, a CONTRATADA terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pela CONTRATADA dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto a CONTRATADA não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso a CONTRATADA não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, não fará jus aos efeitos retroativos ou, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.  Parágrafo Quinto Se o processo de reajuste e/ou revisão de preços não for concluído até o vencimento do Contrato, e este for prorrogado, sua continuidade após o reequilíbrio econômico-financeiro ficará condicionada à manutenção da Proposta da CONTRATADA como a condição mais vantajosa para o BNDES, podendo este:  I. realizar negociação de preços junto à CONTRATADA, de forma a viabilizar a continuidade do ajuste, quando os novos valores fixados após o reajuste e/ou a revisão de preços estiverem acima do patamar apurado no mercado; ou  II. rescindir o Contrato, mediante aviso prévio à CONTRATADA, com antecedência de 30 (trinta) dias, quando resultar infrutífera a negociação indicada no Inciso anterior.  Parágrafo Sexto Na ocorrência da hipótese prevista no Inciso II do Parágrafo anterior, a CONTRATADA fará jus à integralidade dos valores apurados no processo de reajuste e/ou revisão de preços até o término do Contrato, não podendo, todavia, reclamar qualquer indenização em razão da rescisão do mesmo.').
contract_clause(contrato_ocs_200_2020, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS', 'O BNDES e a CONTRATADA, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.   Parágrafo Primeiro O reajuste de preço aludido na Matriz de Riscos deve respeitar o disposto na Cláusula 8 de Equilíbrio Econômico-Financeiro deste Contrato.  Parágrafo Segundo É vedada a celebração de aditivos decorrentes de eventos supervenientes alocados, na Matriz de Riscos, como de responsabilidade da CONTRATADA.').
contract_clause(contrato_ocs_200_2020, clausula_decima_obrigacoes_contratada, 'CLÁUSULA DÉCIMA– OBRIGAÇÕES DA CONTRATADA', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações da CONTRATADA:  I -   Notificar ao BNDES, por escrito, quaisquer fatos que possam por em risco a execução do presente objeto. II -  Não efetuar a compilação reversa, montagem reversa ou engenharia reversa de qualquer programa aplicativo a que venha ter acesso por força do serviço. III - Manter ou incluir em todo material relacionado ao projeto que venha a produzir, uma nota de confidencialidade fornecida pelo BNDES, conforme modelo aprovado pelas partes durante a execução do Contrato. IV - Garantir que as pessoas com acesso a qualquer parte das informações do BNDES estejam avisadas de sua natureza confidencial e da obrigação relacionada a este fato. V - Exigir que seus empregados utilizem as informações decorrentes deste Contrato como informações classificadas como sigilosas. VII - Entregar, ao término do Contrato impreterivelmente ou a qualquer tempo, a pedido do BNDES, todas as documentações que o BNDES tenha lhe fornecido. VIII - Observar as demais normas relativas ao sigilo e à confidencialidade de informações e dados disponibilizados, conforme determinado nas Minutas de Termo de Confidencialidade, a ser assinado pelo representante legal do Contratado. VIII -  Adotar medidas de segurança adequadas, no âmbito das atividades sob seu controle, para a manutenção do sigilo referido nos itens 4.1.8 a  4.1.13 das Especificações Técnicas; IX - Observar as normas de segurança quando for necessário o acesso às dependências do BNDES. X - Observar, durante a execução dos serviços contratados, o fiel cumprimento das leis federais, estaduais e municipais vigentes ou que venham a viger, sendo a única responsável pelas infrações que venham a ser cometidas. XII - Garantir que as atualizações da SOLUÇÃO sejam entregues, corretamente instaladas de acordo com as orientações do CONTRATADO e desempenhem todas as funções e especificações previstas neste documento e na proposta apresentada pelo Contratado. XIII - Ser responsável por quaisquer encargos, de natureza civil, fiscal, comercial, 9 trabalhista ou previdenciária, decorrentes da execução dos serviços contratados, cumprindo ao BNDES tão somente o pagamento do preço na forma ajustada. XIV - Ser responsável pela reparação de quaisquer danos causados ao BNDES ou a terceiros por culpa ou dolo de seus representantes legais, prepostos ou empregados, em decorrência da presente relação contratual, não excluindo essa responsabilidade a fiscalização ou o acompanhamento da execução das atividades previstas pelo BNDES. XV - Apurado o dano e caracterizada sua autoria por qualquer empregado do Contratado, esta pagará ao BNDES o valor correspondente, sendo o valor desta indenização descontado da(s) fatura(s) vincenda(s), mediante compensação ou recolhimento à tesouraria do BNDES. XVI - Aceitar, por parte do BNDES, em todos os aspectos, a fiscalização nos serviços executados. XVII – Permitir ao Banco Central do Brasil acesso a termos firmados, documentos e informações atinentes aos serviços prestados, bem como às suas dependências, nos termos do § 1 do artigo 33 da Resolução CMN n 4557/2017.').
contract_metadata_raw(contrato_ocs_200_2020, 'CLÁUSULA DÉCIMA PRIMEIRA – CONDUTA ÉTICA DA CONTRATADA E DO BNDES', 'A CONTRATADA e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta em preceitos éticos e, em especial, na sua responsabilidade socioambiental.', 'preambulo').
contract_clause(contrato_ocs_200_2020, clausula_decima_primeira_conduta_etica, 'CLÁUSULA DÉCIMA PRIMEIRA – CONDUTA ÉTICA DA CONTRATADA E DO BNDES', 'A CONTRATADA e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta em preceitos éticos e, em especial, na sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, a CONTRATADA obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; 10 IV. observar o Código de Ética do Sistema BNDES vigente ao tempo da contratação, bem como a Política de Conduta e Integridade no âmbito das licitações e contratos administrativos e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, à CONTRATADA, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete à CONTRATADA afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto A CONTRATADA declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e Integridade no âmbito das licitações e contratos administrativos e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_200_2020, clausula_decima_segunda_sigilo_informacoes, 'CLÁUSULA DÉCIMA SEGUNDA – SIGILO DAS INFORMAÇÕES', 'Cabe à CONTRATADA cumprir as seguintes regras de sigilo e assegurar a aceitação e adesão às mesmas por profissionais que integrem ou venham a integrar a sua equipe na prestação do objeto deste Contrato, as quais perdurarão, inclusive, após a cessação do vínculo contratual e da prestação do serviço: 11 I. cumprir as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES, necessárias para assegurar a integridade e o sigilo das informações;  II. não acessar informações sigilosas do BNDES, salvo quando previamente autorizado por escrito; III. sempre que tiver acesso às informações mencionadas no Inciso anterior: a) manter sigilo dessas informações, não podendo copiá-las, reproduzi-las, retê-las ou praticar qualquer outra forma de uso que não seja imprescindível para a adequada prestação do objeto deste Contrato; b) limitar o acesso às informações aos profissionais envolvidos na prestação do serviço objeto deste Contrato, os quais deverão estar cientes da natureza sigilosa das informações e das obrigações e responsabilidades decorrentes do uso dessas informações; e c) informar imediatamente ao BNDES qualquer violação das regras de sigilo ora estabelecidas que tenha ocorrido por sua ação ou omissão, independente da existência de dolo, bem como dos profissionais envolvidos, adotando todas as orientações do BNDES para remediar a violação; IV. entregar ao BNDES, ao término da vigência deste Contrato, todo e qualquer material de propriedade deste, inclusive notas pessoais envolvendo matéria sigilosa e registro de documentos de qualquer natureza que tenham sido criados, usados ou mantidos sob seu controle ou posse, assumindo o compromisso de não utilizar qualquer informação sigilosa a que teve acesso no âmbito deste Contrato;  V. apresentar, antes do início da prestação do serviço, Termos de Confidencialidade, conforme modelo anexo a este Contrato, assinados pelos profissionais que acessarão informações sigilosas, devendo referida obrigação ser também cumprida por ocasião de substituição desses profissionais; e VI. observar o disposto no Termo de Confidencialidade assinado por seus representantes legais, anexo a este Contrato.').
contract_clause(contrato_ocs_200_2020, clausula_decima_terceira_obrigacoes_bndes, 'CLÁUSULA DÉCIMA TERCEIRA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis, vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos à CONTRATADA, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Luís Felipe Santos Silva, que atualmente exerce a função de Gerente da ATI/DESIS4/GSEC, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução do serviço, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; 12 III. designar, como substituto do Gestor do Contrato, para atuar em sua eventual ausência, quem atualmente o estiver substituindo na função de Gerente da  ATI/DESIS4/GSEC; IV. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita à CONTRATADA; V. fornecer à CONTRATADA, quando solicitado ao Gestor do Contrato, cópia do Código de Ética do Sistema BNDES, da Política de Conduta e Integridade no âmbito das licitações e contratos administrativos, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; VI. colocar à disposição da CONTRATADA todas as informações necessárias à perfeita execução do serviço objeto deste Contrato; e VII. comunicar à CONTRATADA, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares da CONTRATADA, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_200_2020, clausula_decima_quarta_cessao_contrato_subcontratacao, 'CLÁUSULA DÉCIMA QUARTA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO', 'É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte da CONTRATADA, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro  É vedada a sucessão contratual, salvo nas hipóteses em que a CONTRATADA realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais, previstos nas Especificações Técnicas.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É vedada a subcontratação para a execução do objeto deste Contrato.  13').
contract_clause(contrato_ocs_200_2020, clausula_decima_quinta_penalidades, 'CLÁUSULA DÉCIMA QUINTA – PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, a CONTRATADA ficará sujeita às seguintes penalidades: I. Advertência; II. Multa por hora útil de atraso, aplicada sobre o valor global do serviço correspondente, em razão do não atendimento dos níveis mínimos de serviço previstos no item 0 das Especificações Técnicas. A multa em questão, a ser aplicada segundo a tabela abaixo, deve ser considerada apenas nos casos em que um chamado continue não iniciado após atingir o valor máximo de ajuste de pagamento especificado no item 0 das Especificações Técnicas.  Severidade Penalidade ALTA Até 5% MÉDIA Até 3% BAIXA Até 1% III. Multa de até 20% (vinte por cento) do valor global do contrato, apurada de acordo com a gravidade da infração, para o descumprimento de quaisquer outras obrigações contratuais. IV. Suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades indicadas nesta Cláusula somente poderão ser aplicadas após procedimento administrativo, e desde que assegurados o contraditório e a ampla defesa, facultada à CONTRATADA a defesa prévia, no prazo de 10 (dez) dias úteis.  Parágrafo Segundo Contra a decisão de aplicação de penalidade, a CONTRATADA poderá interpor o recurso cabível, na forma e no prazo previstos no Regulamento de Formalização, Execução e Fiscalização de Contratos Administrativos do Sistema BNDES.  Parágrafo Terceiro A imposição de sanção prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do 14 Contrato.   Parágrafo Quarto A multa prevista nesta Cláusula poderá ser aplicada juntamente com as demais penalidades e não poderá exceder o montante de 30% (trinta por cento) do valor global do contrato durante a vigência contratual.  Parágrafo Quinto A multa aplicada à CONTRATADA e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ela devidos, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto No caso de uso indevido de informações sigilosas, observar-se-ão, no que couber, os termos da Lei nº 12.527/2011 e do Decreto nº 7.724/2012.  Parágrafo Sétimo No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Oitavo A sanção prevista no Inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_200_2020, clausula_decima_sexta_alteracoes_contratuais, 'CLÁUSULA DÉCIMA SEXTA – ALTERAÇÕES CONTRATUAIS', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:    I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas nas Especificações Técnicas (Anexo I deste Contrato).  15 Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.  Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento e os pequenos ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato, que poderão ser formalizados por meio epistolar.').
contract_clause(contrato_ocs_200_2020, clausula_decima_setima_extincao_contrato, 'CLÁUSULA DÉCIMA SÉTIMA – EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, convencionando-se, ainda, que é cabível a sua resolução:  I. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo; III. quando for decretada a falência da CONTRATADA; IV. caso a CONTRATADA perca uma das condições de habilitação exigidas quando da contratação; V. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VI. caso a CONTRATADA seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  VII. em função da suspensão do direito de a CONTRATADA licitar ou contratar com o BNDES; VIII. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei n.º 12.846/2013, cometido pela CONTRATADA no processo de contratação ou por ocasião da execução contratual; 16 IX. em razão da dissolução da CONTRATADA; e X. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato e oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_200_2020, clausula_decima_oitava_disposicoes_finais, 'CLÁUSULA DÉCIMA OITAVA – DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram este Contrato as Especificações Técnicas, a Proposta da CONTRATADA, a Matriz de Riscos e o Termo de Confidencialidade, respectivamente, Anexos I, II, III e IV ao presente Instrumento, no que com este não colidir, bem como com as disposições legais aplicáveis, observando-se que, ocorrendo conflitos de interpretação entre as disposições contratuais e de seus anexos, prevalecerá o disposto no Contrato e na legislação em vigor.  Parágrafo Segundo Caso haja contradição entre os termos da Proposta da CONTRATADA (Anexo II) e os demais Anexos, prevalecerá o estabelecido nestes.  Parágrafo Terceiro A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_200_2020, clausula_decima_nona_foro, 'CLÁUSULA DÉCIMA NONA – FORO', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As folhas deste Contrato foram conferidas por Márcio Oliveira da Rocha, advogado do BNDES, por autorização do representante legal que o assina. 17  E, por estarem assim justos e contratados, firmam o presente Instrumento, redigido em 1 (uma) via, juntamente com as testemunhas abaixo.  Reputa-se celebrado o presente Contrato na última data em que for registrada a assinatura dos representantes Legais do BNDES.').

% ===== END =====
