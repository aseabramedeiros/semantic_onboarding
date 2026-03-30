% ===== KOA Combined Output | contract_id: contrato_ocs_0259_2020 =====

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
% UFO-only grounding generated from: KOA_Contrato_OCS_259_2020_-_Mundivox_(links_Internet).pl
% contract_id: contrato_ocs_0259_2020

instance_of(contrato_ocs_0259_2020, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(mundivox_telecomunicacoes_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_0259_2020).
plays_role(mundivox_telecomunicacoes_ltda, hired_service_provider_role, contrato_ocs_0259_2020).

clause_of(clausula_primeira_objeto, contrato_ocs_0259_2020).
clause_of(clausula_segunda_vigencia, contrato_ocs_0259_2020).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_0259_2020).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_0259_2020).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_0259_2020).
clause_of(clausula_sexta_preco, contrato_ocs_0259_2020).
clause_of(clausula_setima_pagamento, contrato_ocs_0259_2020).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_0259_2020).
clause_of(clausula_decima_garantia_contratual, contrato_ocs_0259_2020).
clause_of(clausula_decima_primeira_obrigações_contratada, contrato_ocs_0259_2020).
clause_of(clausula_decima_segunda_conduta_etica, contrato_ocs_0259_2020).
clause_of(clausula_decima_terceira_sigilo, contrato_ocs_0259_2020).
clause_of(clausula_decima_quarta_obrigacoes_bndes, contrato_ocs_0259_2020).
clause_of(clausula_decima_quinta_cessao, contrato_ocs_0259_2020).
clause_of(clausula_decima_sexta_penalidades, contrato_ocs_0259_2020).
clause_of(clausula_decima_setima_alteracoes_contratuais, contrato_ocs_0259_2020).
clause_of(clausula_decima_oitava_extincao_contrato, contrato_ocs_0259_2020).
clause_of(clausula_decima_nona_disposicoes_finais, contrato_ocs_0259_2020).
clause_of(clausula_vigesima_foro, contrato_ocs_0259_2020).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_0259_2020).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, mundivox_telecomunicacoes_ltda, provide_data_communication_services).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_data_communication_services).
legal_relation_instance(clausula_primeira_objeto, duty_to_act, mundivox_telecomunicacoes_ltda, install_and_maintain_resources).
legal_relation_instance(clausula_primeira_objeto, duty_to_act, mundivox_telecomunicacoes_ltda, provide_security_service).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, have_resources_installed_and_maintained).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_security_service).
legal_relation_instance(clausula_primeira_objeto, duty_to_act, mundivox_telecomunicacoes_ltda, reallocate_equipment_and_circuits).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, have_equipment_and_circuits_reallocated).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, mundivox_telecomunicacoes_ltda, implement_internet_access_service).
legal_relation_instance(clausula_segunda_vigencia, right_to_action, mundivox_telecomunicacoes_ltda, implement_internet_access_service).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, mundivox_telecomunicacoes_ltda, execute_service_according_to_proposal).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, mundivox_telecomunicacoes_ltda, execute_service_according_to_term).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_service_execution_according_to_proposal).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_service_execution_according_to_term).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, mundivox_telecomunicacoes_ltda, execute_service_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, mundivox_telecomunicacoes_ltda, be_subject_to_price_reduction).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, stipulate_service_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_price_reduction).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_service_execution_per_standards).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, mundivox_telecomunicacoes_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_quinta_recebimento_objeto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_sexta_preco, no_right_to_action, mundivox_telecomunicacoes_ltda, demand_indemnization).
legal_relation_instance(clausula_sexta_preco, subjection, mundivox_telecomunicacoes_ltda, bear_burdens_of_error).
legal_relation_instance(clausula_sexta_preco, duty_to_act, mundivox_telecomunicacoes_ltda, complement_quantities).
legal_relation_instance(clausula_sexta_preco, duty_to_act, mundivox_telecomunicacoes_ltda, execute_contract_object).
legal_relation_instance(clausula_sexta_preco, right_to_action, mundivox_telecomunicacoes_ltda, receive_payment).
legal_relation_instance(clausula_sexta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_party).
legal_relation_instance(clausula_sexta_preco, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, reduce_values_proportionally).
legal_relation_instance(clausula_sexta_preco, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, partially_execute_and_receive).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effectuate_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_subcontractor).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, mundivox_telecomunicacoes_ltda, present_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, right_to_action, mundivox_telecomunicacoes_ltda, receive_payment).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_correction).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, mundivox_telecomunicacoes_ltda, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, mundivox_telecomunicacoes_ltda, request_price_adjustment).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_price_adjustment_revision_request).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, no_right_to_action, mundivox_telecomunicacoes_ltda, request_price_adjustment_revision_after_deadline).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, mundivox_telecomunicacoes_ltda, request_price_adjustment_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, mundivox_telecomunicacoes_ltda, provide_documentation_for_cost_variation).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, mundivox_telecomunicacoes_ltda, provide_information_requested_by_bndes).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, mundivox_telecomunicacoes_ltda, provide_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extend_guarantee_presentation_deadline).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, mundivox_telecomunicacoes_ltda, complement_or_replace_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, mundivox_telecomunicacoes_ltda, obtain_guarantor_consent).
legal_relation_instance(clausula_decima_garantia_contratual, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalty_if_guarantee_not_provided).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, mundivox_telecomunicacoes_ltda, obtain_new_guarantee).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, mundivox_telecomunicacoes_ltda, maintain_qualification).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, mundivox_telecomunicacoes_ltda, inform_penalties).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, mundivox_telecomunicacoes_ltda, repair_defects).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, mundivox_telecomunicacoes_ltda, repair_damages).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, mundivox_telecomunicacoes_ltda, pay_taxes).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, mundivox_telecomunicacoes_ltda, exclude_simples_nacional).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, mundivox_telecomunicacoes_ltda, obey_instructions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, mundivox_telecomunicacoes_ltda, appoint_representative).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, mundivox_telecomunicacoes_ltda, support_transition).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, mundivox_telecomunicacoes_ltda, ensure_no_copyright_infringement).
legal_relation_instance(clausula_decima_segunda_conduta_etica, duty_to_act, mundivox_telecomunicacoes_ltda, maintain_integrity).
legal_relation_instance(clausula_decima_segunda_conduta_etica, duty_to_act, mundivox_telecomunicacoes_ltda, act_in_good_faith).
legal_relation_instance(clausula_decima_segunda_conduta_etica, duty_to_omit, mundivox_telecomunicacoes_ltda, not_offer_undue_advantage).
legal_relation_instance(clausula_decima_segunda_conduta_etica, duty_to_omit, mundivox_telecomunicacoes_ltda, prevent_favoritism).
legal_relation_instance(clausula_decima_segunda_conduta_etica, duty_to_omit, mundivox_telecomunicacoes_ltda, not_allocate_family_members).
legal_relation_instance(clausula_decima_segunda_conduta_etica, duty_to_act, mundivox_telecomunicacoes_ltda, observe_code_of_ethics).
legal_relation_instance(clausula_decima_segunda_conduta_etica, duty_to_act, mundivox_telecomunicacoes_ltda, remove_agents_immediately).
legal_relation_instance(clausula_decima_segunda_conduta_etica, duty_to_act, mundivox_telecomunicacoes_ltda, communicate_fact_to_bndes).
legal_relation_instance(clausula_decima_segunda_conduta_etica, duty_to_act, mundivox_telecomunicacoes_ltda, prevent_undue_advantage).
legal_relation_instance(clausula_decima_segunda_conduta_etica, duty_to_act, mundivox_telecomunicacoes_ltda, adopt_sustainable_practices).
legal_relation_instance(clausula_decima_terceira_sigilo, duty_to_act, mundivox_telecomunicacoes_ltda, comply_with_bndes_info_security_policy).
legal_relation_instance(clausula_decima_terceira_sigilo, duty_to_omit, mundivox_telecomunicacoes_ltda, not_access_confidential_info_without_authorization).
legal_relation_instance(clausula_decima_terceira_sigilo, duty_to_act, mundivox_telecomunicacoes_ltda, maintain_confidentiality_of_info).
legal_relation_instance(clausula_decima_terceira_sigilo, duty_to_act, mundivox_telecomunicacoes_ltda, limit_access_to_info).
legal_relation_instance(clausula_decima_terceira_sigilo, duty_to_act, mundivox_telecomunicacoes_ltda, inform_bndes_of_secrecy_violations).
legal_relation_instance(clausula_decima_terceira_sigilo, duty_to_act, mundivox_telecomunicacoes_ltda, return_bndes_property_at_end_of_contract).
legal_relation_instance(clausula_decima_terceira_sigilo, duty_to_omit, mundivox_telecomunicacoes_ltda, not_use_confidential_info_after_contract).
legal_relation_instance(clausula_decima_terceira_sigilo, duty_to_act, mundivox_telecomunicacoes_ltda, observe_confidentiality_term).
legal_relation_instance(clausula_decima_quarta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, realizar_pagamentos_devidos).
legal_relation_instance(clausula_decima_quarta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designar_gestor_contrato).
legal_relation_instance(clausula_decima_quarta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, colocar_disposicao_informacoes).
legal_relation_instance(clausula_decima_quarta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, comunicar_instrucoes).
legal_relation_instance(clausula_decima_quarta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, comunicar_abertura_procedimento).
legal_relation_instance(clausula_decima_quarta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, comunicar_aplicacao_penalidade).
legal_relation_instance(clausula_decima_quarta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, fornecer_codigo_etica).
legal_relation_instance(clausula_decima_quarta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alterar_gestor_contrato).
legal_relation_instance(clausula_decima_quinta_cessao, duty_to_omit, mundivox_telecomunicacoes_ltda, omit_contract_cession).
legal_relation_instance(clausula_decima_quinta_cessao, no_right_to_action, mundivox_telecomunicacoes_ltda, no_right_to_contract_cession).
legal_relation_instance(clausula_decima_quinta_cessao, duty_to_omit, mundivox_telecomunicacoes_ltda, omit_credit_cession).
legal_relation_instance(clausula_decima_quinta_cessao, no_right_to_action, mundivox_telecomunicacoes_ltda, no_right_to_credit_cession).
legal_relation_instance(clausula_decima_quinta_cessao, duty_to_omit, mundivox_telecomunicacoes_ltda, omit_credit_title_emission).
legal_relation_instance(clausula_decima_quinta_cessao, no_right_to_action, mundivox_telecomunicacoes_ltda, no_right_to_credit_title_emission).
legal_relation_instance(clausula_decima_quinta_cessao, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_risks_prejudices).
legal_relation_instance(clausula_decima_quinta_cessao, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_risks_prejudices_subcontrataction).
legal_relation_instance(clausula_decima_quinta_cessao, duty_to_act, mundivox_telecomunicacoes_ltda, present_confidentiality_terms).
legal_relation_instance(clausula_decima_quinta_cessao, duty_to_omit, mundivox_telecomunicacoes_ltda, omit_contractual_succession).
legal_relation_instance(clausula_decima_sexta_penalidades, subjection, mundivox_telecomunicacoes_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_decima_sexta_penalidades, right_to_action, mundivox_telecomunicacoes_ltda, file_appeal).
legal_relation_instance(clausula_decima_sexta_penalidades, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, conduct_administrative_procedure).
legal_relation_instance(clausula_decima_sexta_penalidades, right_to_action, mundivox_telecomunicacoes_ltda, prior_defense).
legal_relation_instance(clausula_decima_sexta_penalidades, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_sexta_penalidades, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, judicial_collection).
legal_relation_instance(clausula_decima_sexta_penalidades, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, impose_penalties).
legal_relation_instance(clausula_decima_sexta_penalidades, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, assure_contradictory_and_full_defense).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alter_contract_by_agreement).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_alteration).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_refusal_to_alter_contract).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, allege_just_cause_for_refusal).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, claim_damages_for_unjustified_refusal).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, be_liable_for_damages).
legal_relation_instance(clausula_decima_oitava_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_other_party).
legal_relation_instance(clausula_decima_oitava_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_opportunity_to_defend).
legal_relation_instance(clausula_decima_oitava_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_oitava_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, right_to_terminate_contract).
legal_relation_instance(clausula_decima_nona_disposicoes_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights_at_any_time).
legal_relation_instance(clausula_decima_nona_disposicoes_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, claim_renunciation_or_novation).
legal_relation_instance(clausula_decima_nona_disposicoes_finais, permission_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_strict_compliance).
legal_relation_instance(clausula_vigesima_foro, power, unknown, resolve_disputes_in_rio_de_janeiro).
legal_relation_instance(clausula_vigesima_foro, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, be_subject_to_rio_de_janeiro_court).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_omit, mundivox_telecomunicacoes_ltda, omit_claims_for_risks_allocated_in_matrix).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, mundivox_telecomunicacoes_ltda, respect_economic_financial_balance).
legal_relation_instance(clausula_nona_matriz_riscos, no_right_to_action, mundivox_telecomunicacoes_ltda, not_claim_for_risks_allocated).

% --- Action catalog (local to this contract grounding) ---
action_type(act_in_good_faith).
action_label(act_in_good_faith, 'Act in good faith').
action_type(adopt_sustainable_practices).
action_label(adopt_sustainable_practices, 'Adopt sustainable practices').
action_type(allege_just_cause_for_refusal).
action_label(allege_just_cause_for_refusal, 'Allege just cause for refusal').
action_type(allow_central_bank_access).
action_label(allow_central_bank_access, 'Allow Central Bank access').
action_type(allow_inspections).
action_label(allow_inspections, 'Allow inspections').
action_type(alter_contract_by_agreement).
action_label(alter_contract_by_agreement, 'Alter contract by agreement').
action_type(alterar_gestor_contrato).
action_label(alterar_gestor_contrato, 'Change contract manager').
action_type(analyze_price_adjustment_revision_request).
action_label(analyze_price_adjustment_revision_request, 'Analyze price adjustment/revision request').
action_type(analyze_risks_prejudices).
action_label(analyze_risks_prejudices, 'Analyze risks/prejudices').
action_type(analyze_risks_prejudices_subcontrataction).
action_label(analyze_risks_prejudices_subcontrataction, 'Analyze risks and prejudices').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_penalty_if_guarantee_not_provided).
action_label(apply_penalty_if_guarantee_not_provided, 'Apply penalty').
action_type(apply_price_reduction).
action_label(apply_price_reduction, 'Apply price reduction').
action_type(appoint_representative).
action_label(appoint_representative, 'Appoint representative').
action_type(assure_contradictory_and_full_defense).
action_label(assure_contradictory_and_full_defense, 'Assure contradictory & full defense').
action_type(be_liable_for_damages).
action_label(be_liable_for_damages, 'Be liable for damages').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Be subject to penalties').
action_type(be_subject_to_price_reduction).
action_label(be_subject_to_price_reduction, 'Be subject to price reduction').
action_type(be_subject_to_rio_de_janeiro_court).
action_label(be_subject_to_rio_de_janeiro_court, 'Subject to Rio court').
action_type(bear_burdens_of_error).
action_label(bear_burdens_of_error, 'Bear burdens of error').
action_type(claim_damages_for_unjustified_refusal).
action_label(claim_damages_for_unjustified_refusal, 'Claim damages for refusal').
action_type(claim_renunciation_or_novation).
action_label(claim_renunciation_or_novation, 'Claim renunciation or novation').
action_type(colocar_disposicao_informacoes).
action_label(colocar_disposicao_informacoes, 'Provide necessary information').
action_type(communicate_fact_to_bndes).
action_label(communicate_fact_to_bndes, 'Communicate fact to BNDES').
action_type(complement_or_replace_guarantee).
action_label(complement_or_replace_guarantee, 'Complement or replace guarantee').
action_type(complement_quantities).
action_label(complement_quantities, 'Complement quantities').
action_type(comply_security_rules).
action_label(comply_security_rules, 'Comply with security rules').
action_type(comply_with_bndes_info_security_policy).
action_label(comply_with_bndes_info_security_policy, 'Comply with BNDES info security policy').
action_type(comunicar_abertura_procedimento).
action_label(comunicar_abertura_procedimento, 'Communicate administrative procedure').
action_type(comunicar_aplicacao_penalidade).
action_label(comunicar_aplicacao_penalidade, 'Communicate penalty application').
action_type(comunicar_instrucoes).
action_label(comunicar_instrucoes, 'Communicate instructions').
action_type(conduct_administrative_procedure).
action_label(conduct_administrative_procedure, 'Conduct administrative procedure').
action_type(demand_indemnization).
action_label(demand_indemnization, 'Demand indemnization').
action_type(demand_service_execution_per_standards).
action_label(demand_service_execution_per_standards, 'Demand service per standards').
action_type(designar_gestor_contrato).
action_label(designar_gestor_contrato, 'Designate contract manager').
action_type(effect_object_receipt).
action_label(effect_object_receipt, 'Effect object receipt').
action_type(effectuate_payment).
action_label(effectuate_payment, 'Effectuate payment').
action_type(ensure_no_copyright_infringement).
action_label(ensure_no_copyright_infringement, 'Ensure no copyright infringement').
action_type(exclude_simples_nacional).
action_label(exclude_simples_nacional, 'Exclude from Simples Nacional').
action_type(execute_contract_object).
action_label(execute_contract_object, 'Execute contract object').
action_type(execute_service_according_to_proposal).
action_label(execute_service_according_to_proposal, 'Execute service per proposal').
action_type(execute_service_according_to_standards).
action_label(execute_service_according_to_standards, 'Execute service per standards').
action_type(execute_service_according_to_term).
action_label(execute_service_according_to_term, 'Execute service per term').
action_type(exercise_rights_at_any_time).
action_label(exercise_rights_at_any_time, 'Exercise rights at any time').
action_type(expect_service_execution_according_to_proposal).
action_label(expect_service_execution_according_to_proposal, 'Expect service as proposed').
action_type(expect_service_execution_according_to_term).
action_label(expect_service_execution_according_to_term, 'Expect service as in term').
action_type(extend_guarantee_presentation_deadline).
action_label(extend_guarantee_presentation_deadline, 'Extend guarantee deadline').
action_type(file_appeal).
action_label(file_appeal, 'File appeal').
action_type(formalize_contract_alteration).
action_label(formalize_contract_alteration, 'Formalize contract alteration').
action_type(fornecer_codigo_etica).
action_label(fornecer_codigo_etica, 'Provide code of ethics').
action_type(have_equipment_and_circuits_reallocated).
action_label(have_equipment_and_circuits_reallocated, 'Have equipment and circuits reallocated').
action_type(have_resources_installed_and_maintained).
action_label(have_resources_installed_and_maintained, 'Have resources installed and maintained').
action_type(implement_internet_access_service).
action_label(implement_internet_access_service, 'Implement internet access service').
action_type(impose_penalties).
action_label(impose_penalties, 'Impose penalties').
action_type(inform_bndes_of_secrecy_violations).
action_label(inform_bndes_of_secrecy_violations, 'Inform BNDES of secrecy violations').
action_type(inform_penalties).
action_label(inform_penalties, 'Inform about penalties').
action_type(install_and_maintain_resources).
action_label(install_and_maintain_resources, 'Install and maintain resources').
action_type(judicial_collection).
action_label(judicial_collection, 'Judicial collection').
action_type(limit_access_to_info).
action_label(limit_access_to_info, 'Limit access to information').
action_type(maintain_confidentiality_of_info).
action_label(maintain_confidentiality_of_info, 'Maintain confidentiality of information').
action_type(maintain_integrity).
action_label(maintain_integrity, 'Maintain integrity').
action_type(maintain_qualification).
action_label(maintain_qualification, 'Maintain qualification conditions').
action_type(no_right_to_contract_cession).
action_label(no_right_to_contract_cession, 'No right to contract cession').
action_type(no_right_to_contractual_succession).
action_label(no_right_to_contractual_succession, 'No right to contractual succession').
action_type(no_right_to_credit_cession).
action_label(no_right_to_credit_cession, 'No right to credit cession').
action_type(no_right_to_credit_title_emission).
action_label(no_right_to_credit_title_emission, 'No right to credit title emission').
action_type(not_access_confidential_info_without_authorization).
action_label(not_access_confidential_info_without_authorization, 'Do not access confidential info w/o authorization').
action_type(not_allocate_family_members).
action_label(not_allocate_family_members, 'Not allocate family members').
action_type(not_claim_for_risks_allocated).
action_label(not_claim_for_risks_allocated, 'No right to claim risks').
action_type(not_offer_undue_advantage).
action_label(not_offer_undue_advantage, 'Not offer undue advantage').
action_type(not_use_confidential_info_after_contract).
action_label(not_use_confidential_info_after_contract, 'Do not use confidential information').
action_type(notify_other_party).
action_label(notify_other_party, 'Notify other party').
action_type(obey_instructions).
action_label(obey_instructions, 'Obey instructions').
action_type(observe_code_of_ethics).
action_label(observe_code_of_ethics, 'Observe code of ethics').
action_type(observe_confidentiality_term).
action_label(observe_confidentiality_term, 'Observe confidentiality term').
action_type(obtain_guarantor_consent).
action_label(obtain_guarantor_consent, 'Obtain guarantor consent').
action_type(obtain_new_guarantee).
action_label(obtain_new_guarantee, 'Obtain new guarantee').
action_type(omit_claims_for_risks_allocated_in_matrix).
action_label(omit_claims_for_risks_allocated_in_matrix, 'Omit claims for risks in matrix').
action_type(omit_contract_cession).
action_label(omit_contract_cession, 'Omit contract cession').
action_type(omit_contractual_succession).
action_label(omit_contractual_succession, 'Omit contractual succession').
action_type(omit_credit_cession).
action_label(omit_credit_cession, 'Omit credit cession').
action_type(omit_credit_title_emission).
action_label(omit_credit_title_emission, 'Omit credit title emission').
action_type(omit_refusal_to_alter_contract).
action_label(omit_refusal_to_alter_contract, 'Do not refuse to alter contract').
action_type(omit_strict_compliance).
action_label(omit_strict_compliance, 'Omit strict compliance').
action_type(partially_execute_and_receive).
action_label(partially_execute_and_receive, 'Partially execute and receive').
action_type(pay_contracted_party).
action_label(pay_contracted_party, 'Pay contracted party').
action_type(pay_subcontractor).
action_label(pay_subcontractor, 'Do not pay subcontractor').
action_type(pay_taxes).
action_label(pay_taxes, 'Pay taxes').
action_type(present_confidentiality_terms).
action_label(present_confidentiality_terms, 'Present confidentiality terms').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(prevent_favoritism).
action_label(prevent_favoritism, 'Prevent favoritism').
action_type(prevent_undue_advantage).
action_label(prevent_undue_advantage, 'Prevent undue advantage').
action_type(prior_defense).
action_label(prior_defense, 'Prior defense').
action_type(provide_contractual_guarantee).
action_label(provide_contractual_guarantee, 'Provide contractual guarantee').
action_type(provide_data_communication_services).
action_label(provide_data_communication_services, 'Provide data communication services').
action_type(provide_documentation_for_cost_variation).
action_label(provide_documentation_for_cost_variation, 'Provide documentation for cost variation').
action_type(provide_information_requested_by_bndes).
action_label(provide_information_requested_by_bndes, 'Provide information requested by BNDES').
action_type(provide_opportunity_to_defend).
action_label(provide_opportunity_to_defend, 'Provide opportunity to defend').
action_type(provide_security_service).
action_label(provide_security_service, 'Provide security service').
action_type(realizar_pagamentos_devidos).
action_label(realizar_pagamentos_devidos, 'Make payments to contractor').
action_type(reallocate_equipment_and_circuits).
action_label(reallocate_equipment_and_circuits, 'Reallocate equipment and circuits').
action_type(receive_data_communication_services).
action_label(receive_data_communication_services, 'Receive data communication services').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_proof_of_regularity).
action_label(receive_proof_of_regularity, 'Receive proof of regularity').
action_type(receive_security_service).
action_label(receive_security_service, 'Receive security service').
action_type(reduce_values_proportionally).
action_label(reduce_values_proportionally, 'Reduce values proportionally').
action_type(remove_agents_immediately).
action_label(remove_agents_immediately, 'Remove agents immediately').
action_type(repair_damages).
action_label(repair_damages, 'Repair damages').
action_type(repair_defects).
action_label(repair_defects, 'Repair defects').
action_type(request_correction).
action_label(request_correction, 'Request correction').
action_type(request_price_adjustment).
action_label(request_price_adjustment, 'Request price adjustment').
action_type(request_price_adjustment_revision).
action_label(request_price_adjustment_revision, 'Request price adjustment/revision').
action_type(request_price_adjustment_revision_after_deadline).
action_label(request_price_adjustment_revision_after_deadline, 'Request price adjustment/revision after deadline').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(require_proof_of_regularity).
action_label(require_proof_of_regularity, 'Require proof of regularity').
action_type(resolve_disputes_in_rio_de_janeiro).
action_label(resolve_disputes_in_rio_de_janeiro, 'Resolve disputes in Rio').
action_type(respect_economic_financial_balance).
action_label(respect_economic_financial_balance, 'Respect financial balance clause.').
action_type(return_bndes_property_at_end_of_contract).
action_label(return_bndes_property_at_end_of_contract, 'Return BNDES property').
action_type(return_resources).
action_label(return_resources, 'Return resources').
action_type(right_to_terminate_contract).
action_label(right_to_terminate_contract, 'Right to terminate contract').
action_type(stipulate_service_standards).
action_label(stipulate_service_standards, 'Stipulate service standards').
action_type(subcontract_portion_of_object).
action_label(subcontract_portion_of_object, 'Subcontract portion of object').
action_type(support_transition).
action_label(support_transition, 'Support transition').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_0259_2020).
contract_metadata(contrato_ocs_0259_2020, numero_ocs, '0259/2020').
contract_metadata(contrato_ocs_0259_2020, numero_sap, '4400004460').
contract_metadata(contrato_ocs_0259_2020, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇO').
contract_metadata(contrato_ocs_0259_2020, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'MUNDIVOX TELECOMUNICAÇÕES LTDA.']).
contract_metadata(contrato_ocs_0259_2020, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_0259_2020, contratado, 'MUNDIVOX TELECOMUNICAÇÕES LTDA.').
contract_metadata(contrato_ocs_0259_2020, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_0259_2020, cnpj_contratado, '07.228.550/0001-01').
contract_metadata(contrato_ocs_0259_2020, procedimento_licitatorio, 'Pregão Eletrônico nº 49/2020').
contract_metadata(contrato_ocs_0259_2020, data_autorizacao, '14/10/2020').
contract_metadata_raw(contrato_ocs_0259_2020, 'ip_ati_deset', '31/2020', 'trecho_literal').
contract_metadata_raw(contrato_ocs_0259_2020, 'rubrica_orcamentaria', '3101300003', 'trecho_literal').
contract_metadata_raw(contrato_ocs_0259_2020, 'rubrica_orcamentaria', '3101300099', 'trecho_literal').
contract_metadata(contrato_ocs_0259_2020, centro_custo, 'BN00004000').
contract_metadata(contrato_ocs_0259_2020, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_0259_2020, regulamento, 'Regulamento de Formalização, Execução e Fiscalização dos Contratos Administrativos do Sistema BNDES').
contract_clause(contrato_ocs_0259_2020, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a prestação de serviços de comunicação de dados para acesso permanente, dedicado, exclusivo e por meio do protocolo IP à rede mundial de computadores Internet, incluindo a instalação, sustentação dos recursos necessários para prestação do serviço, bem como a prestação do serviço de segurança para proteção de acesso à Internet e a prestação do serviço de remanejamento dos equipamentos e circuitos disponibilizados nas instalações do BNDES, conforme especificações constantes do Termo de Referência e da Proposta apresentada pela CONTRATADA, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_0259_2020, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de:  I. até 6 (seis) meses, contados da convocação do BNDES, para implantação do serviço pela CONTRATADA, incluindo todas as fases até a emissão do Termo de Recebimento Definitivo do Serviço de ACESSO INTERNET; e II. até 60 (sessenta) meses, contados a partir da emissão do Termo de Recebimento Definitivo do Serviço de Acesso Internet, no que concerne ao serviço contínuo de Acesso Internet.').
contract_clause(contrato_ocs_0259_2020, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do serviço respeitará as especificações constantes da Proposta apresentada pela CONTRATADA e do Termo de Referência, respectivamente, Anexos II e I deste Contrato.').
contract_clause(contrato_ocs_0259_2020, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'O serviço contratado deverá ser executado de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados pelo BNDES, segundo as metas de nível de serviço descritas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Único O descumprimento de qualquer meta de nível de serviço pactuada acarretará a aplicação de índice de redução do preço previsto no Termo de Referência, sem prejuízo da aplicação das penalidades previstas neste Contrato, quando cabíveis.').
contract_clause(contrato_ocs_0259_2020, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do Gestor, mencionado na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Termo de Referência (Anexo I deste Contrato).').
contract_clause(contrato_ocs_0259_2020, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará à CONTRATADA, pela execução do objeto contratado, o valor de até R$ 1.991.878,60 (um milhão, novecentos e noventa e um mil, oitocentos e setenta e oito reais e  sessenta centavos), conforme Proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento.  Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização à CONTRATADA.  Parágrafo Quarto A CONTRATADA deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua Proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua Proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato.').
contract_clause(contrato_ocs_0259_2020, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, observado o disposto no Anexo I (Termo de Referência), por meio de crédito em conta bancária, em até 10 (dez) dias úteis, a contar da data de apresentação do documento fiscal ou equivalente legal (como nota fiscal, fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pela CONTRATADA.   Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte, mediante prévia autorização do BNDES.    Parágrafo Segundo Nas hipóteses em que o recebimento definitivo ocorrer após a entrega do documento fiscal ou equivalente legal, o BNDES terá até 10 (dez) dias úteis, a contar da data em que o objeto tiver sido recebido definitivamente, para efetuar o pagamento.   Parágrafo Terceiro Para toda efetivação de pagamento, a CONTRATADA deverá encaminhar 1 (uma) via do documento fiscal ou equivalente legal ao sistema de captação de notas fiscais eletrônicas do BNDES, ou, quando emitido em papel, ao Protocolo do Edifício de Serviços do BNDES no Rio de Janeiro - EDSERJ, localizado na Avenida República do Chile nº 100, Térreo, Centro, Rio de Janeiro, CEP nº 20.031-917, no período compreendido entre 10h e 18h.   Parágrafo Quarto O BNDES não efetuará pagamento diretamente em favor da(s) SUBCONTRATADA(S).   Parágrafo Quinto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor do Contrato  V. descrição detalhada do objeto executado e dos respectivos valores; VI. período de referência da execução do objeto; VII. nome e número do CNPJ da CONTRATADA, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VIII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; IX. nome e número do banco e da agência, bem como o número da conta corrente da CONTRATADA, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; X. tomador dos serviços: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; XI. CNPJ do tomador dos serviços: 33.657.248/0001-89;  XII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso; e  XIII. código dos serviços, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento.  Parágrafo Sexto O documento fiscal ou equivalente legal emitido pela CONTRATADA deverá estar em conformidade com a legislação do Município onde a CONTRATADA esteja estabelecido, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos federais, sob pena de devolução do documento e interrupção do prazo para pagamento.  Parágrafo Sétimo  Caso a CONTRATADA emita documento fiscal ou equivalente legal autorizado por Município diferente daquele onde se localiza o estabelecimento do BNDES tomador do serviço e destinatário da cobrança, deverá providenciar o cadastro junto à Secretaria Municipal de Fazenda ou órgão equivalente do Município do estabelecimento tomador, salvo quando se aplicar uma das exceções constantes dos incisos do artigo 3º da Lei Complementar Federal nº 116/03. A inexistência desse cadastro ou o cadastro em item diverso do faturado não constitui impeditivo ao processo de pagamento, mas um ônus a ser suportado pela CONTRATADA, uma vez que o BNDES está obrigado a reter na fonte a quantia equivalente ao ISS dos serviços faturados, conforme legislação aplicável.  Parágrafo Oitavo Ao documento fiscal ou equivalente legal deverão ser anexados:  I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que a CONTRATADA é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado; e V. comprovante de que a CONTRATADA recolheu para o Regime Geral de Previdência Social, no mês respectivo, sobre o limite máximo do salário-de-contribuição ou em valor inferior, se for o caso.      Parágrafo Nono Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal à CONTRATADA ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Décimo Os pagamentos a serem efetuados em favor da CONTRATADA estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pela CONTRATADA.  Parágrafo Décimo Primeiro Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pela CONTRATADA.  Parágrafo Décimo Segundo Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível à CONTRATADA, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.').
contract_clause(contrato_ocs_0259_2020, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO O BNDES e a CONTRATADA têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pela CONTRATADA a cada período de 12 (doze) meses, sendo o primeiro contado do dia 19/11/2020, data limite para a apresentação da Proposta (Anexo II deste Contrato), e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do Índice de Custo de Tecnologia da Informação - ICTI, divulgado pelo Instituto de Pesquisa Econômica Aplicada – IPEA acumulado, sobre o preço referido na Cláusula de Preço deste Instrumento.   Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação da CONTRATADA, quando ocorrer fato imprevisível ou previsível, porém, de consequências  incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado à CONTRATADA nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. a CONTRATADA deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da Proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, a CONTRATADA deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da Proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar a CONTRATADA para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na Proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo à CONTRATADA apresentar as informações solicitadas pelo BNDES.   Parágrafo Quarto A CONTRATADA deverá solicitar o reajuste e/ou a revisão de preços até o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias do encerramento do Contrato, a CONTRATADA terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a divulgação do índice de reajuste ocorra após o encerramento do Contrato, a CONTRATADA terá o prazo de 60 (sessenta) dias, a contar da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pela CONTRATADA dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do  BNDES, enquanto a CONTRATADA não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso a CONTRATADA não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.', 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO O BNDES e a CONTRATADA têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pela CONTRATADA a cada período de 12 (doze) meses, sendo o primeiro contado do dia 19/11/2020, data limite para a apresentação da Proposta (Anexo II deste Contrato), e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do Índice de Custo de Tecnologia da Informação - ICTI, divulgado pelo Instituto de Pesquisa Econômica Aplicada – IPEA acumulado, sobre o preço referido na Cláusula de Preço deste Instrumento.   Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação da CONTRATADA, quando ocorrer fato imprevisível ou previsível, porém, de consequências  incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado à CONTRATADA nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. a CONTRATADA deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da Proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, a CONTRATADA deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da Proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar a CONTRATADA para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na Proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo à CONTRATADA apresentar as informações solicitadas pelo BNDES.   Parágrafo Quarto A CONTRATADA deverá solicitar o reajuste e/ou a revisão de preços até o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias do encerramento do Contrato, a CONTRATADA terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a divulgação do índice de reajuste ocorra após o encerramento do Contrato, a CONTRATADA terá o prazo de 60 (sessenta) dias, a contar da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pela CONTRATADA dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do  BNDES, enquanto a CONTRATADA não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso a CONTRATADA não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.').
contract_clause(contrato_ocs_0259_2020, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS O BNDES e a CONTRATADA, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.   Parágrafo Primeiro O reajuste de preço aludido na Matriz de Riscos deve respeitar o disposto na
contract_clause(contrato_ocs_0259_2020, clausula_decima_garantia_contratual, 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL A CONTRATADA prestará garantia contratual, no prazo de até 10 (dez) dias úteis, contados da convocação, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para a sua aceitação estipuladas nos incisos abaixo, no valor de R$ 99.593,93 (noventa e nove mil, quinhentos e noventa e três reais e noventa e três centavos), correspondente a 5 % (cinco por cento) do valor do presente Contrato, que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas por este; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a)  O Instrumento de Apólice de Seguro deve prever expressamente: 1. responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas à CONTRATADA;  2. vigência pelo prazo contratual; 3. prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento da CONTRATADA - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a)  O Instrumento de Fiança deve prever expressamente: 1. renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; 2. vigência pelo prazo contratual; 3. prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento da CONTRATADA - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pela CONTRATADA durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Em caso de alteração do valor contratual, utilização total ou parcial da garantia pelo BNDES, ou em situações outras que impliquem em perda ou insuficiência da garantia, a CONTRATADA deverá providenciar a complementação ou substituição da garantia prestada no prazo determinado pelo BNDES ou pactuado em aditivo ou em apostilamento, observadas as condições originais para aceitação da garantia estipuladas nesta Cláusula.  Parágrafo Terceiro Nos demais casos de alteração do Contrato, sempre que o mesmo for garantido por fiança bancária ou seguro garantia, a CONTRATADA deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe à CONTRATADA obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.   Parágrafo Quarto No caso de Consórcio, somente será aceita uma única garantia.', 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL A CONTRATADA prestará garantia contratual, no prazo de até 10 (dez) dias úteis, contados da convocação, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para a sua aceitação estipuladas nos incisos abaixo, no valor de R$ 99.593,93 (noventa e nove mil, quinhentos e noventa e três reais e noventa e três centavos), correspondente a 5 % (cinco por cento) do valor do presente Contrato, que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas por este; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a)  O Instrumento de Apólice de Seguro deve prever expressamente: 1. responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas à CONTRATADA;  2. vigência pelo prazo contratual; 3. prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento da CONTRATADA - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a)  O Instrumento de Fiança deve prever expressamente: 1. renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; 2. vigência pelo prazo contratual; 3. prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento da CONTRATADA - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pela CONTRATADA durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Em caso de alteração do valor contratual, utilização total ou parcial da garantia pelo BNDES, ou em situações outras que impliquem em perda ou insuficiência da garantia, a CONTRATADA deverá providenciar a complementação ou substituição da garantia prestada no prazo determinado pelo BNDES ou pactuado em aditivo ou em apostilamento, observadas as condições originais para aceitação da garantia estipuladas nesta Cláusula.  Parágrafo Terceiro Nos demais casos de alteração do Contrato, sempre que o mesmo for garantido por fiança bancária ou seguro garantia, a CONTRATADA deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe à CONTRATADA obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.   Parágrafo Quarto No caso de Consórcio, somente será aceita uma única garantia.').
contract_clause(contrato_ocs_0259_2020, clausula_decima_primeira_obrigações_contratada, 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DA CONTRATADA Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações da CONTRATADA: I. manter durante a vigência deste Contrato todas as condições de habilitação e qualificação exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição, a si ou a qualquer consorciada, de penalidade que acarrete o impedimento de contratar com o BNDES. III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir da CONTRATADA a comprovação de sua regularidade; VI. providenciar, perante a Receita Federal do Brasil – RFB, comprovando ao BNDES, sua exclusão obrigatória do  Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se a CONTRATADA, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das exceções previstas no artigo 17 da Lei Complementar nº 123/2006; VII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; VIII. obedecer às instruções e aos procedimentos estabelecidos pelo BNDES para a adequada execução do Contrato; IX. designar 1 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor da CONTRATADA, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; X. permitir ao Banco Central do Brasil acesso a termos firmados, documentos e informações atinentes aos serviços prestados, bem como às suas dependências, nos termos do § 1º do artigo 33 da Resolução CMN nº 4.557/2017;      XI. atender às solicitações do BNDES relativas à transição contratual entre a CONTRATADA e o seu sucessor na execução do serviço, prestando todo o suporte, inclusive a capacitação dos profissionais de seu sucessor, a fim de que o objeto contratado não seja interrompido; XII. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo a CONTRATADA ser instada a intervir no processo;  XIII. responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos serviços, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES; e XIV. devolver recursos disponibilizados pelo BNDES, revogar perfis de acesso de seus profissionais, eliminar suas caixas postais e adotar demais providências aplicáveis ao término da vigência do CONTRATO.', 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DA CONTRATADA Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações da CONTRATADA: I. manter durante a vigência deste Contrato todas as condições de habilitação e qualificação exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição, a si ou a qualquer consorciada, de penalidade que acarrete o impedimento de contratar com o BNDES. III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir da CONTRATADA a comprovação de sua regularidade; VI. providenciar, perante a Receita Federal do Brasil – RFB, comprovando ao BNDES, sua exclusão obrigatória do  Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se a CONTRATADA, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das exceções previstas no artigo 17 da Lei Complementar nº 123/2006; VII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; VIII. obedecer às instruções e aos procedimentos estabelecidos pelo BNDES para a adequada execução do Contrato; IX. designar 1 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor da CONTRATADA, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; X. permitir ao Banco Central do Brasil acesso a termos firmados, documentos e informações atinentes aos serviços prestados, bem como às suas dependências, nos termos do § 1º do artigo 33 da Resolução CMN nº 4.557/2017;      XI. atender às solicitações do BNDES relativas à transição contratual entre a CONTRATADA e o seu sucessor na execução do serviço, prestando todo o suporte, inclusive a capacitação dos profissionais de seu sucessor, a fim de que o objeto contratado não seja interrompido; XII. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo a CONTRATADA ser instada a intervir no processo;  XIII. responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos serviços, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES; e XIV. devolver recursos disponibilizados pelo BNDES, revogar perfis de acesso de seus profissionais, eliminar suas caixas postais e adotar demais providências aplicáveis ao término da vigência do CONTRATO.').
contract_clause(contrato_ocs_0259_2020, clausula_decima_segunda_conduta_etica, 'CLÁUSULA DÉCIMA SEGUNDA – CONDUTA ÉTICA DA CONTRATADA E DO BNDES', 'A CONTRATADA e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta em preceitos éticos e, em especial, na sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, a CONTRATADA obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar o Código de Ética do Sistema BNDES vigente ao tempo da contratação,  bem como a Política de Conduta e Integridade no âmbito das licitações e contratos administrativos e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, à CONTRATADA, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete à CONTRATADA afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto A CONTRATADA declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e Integridade no âmbito das licitações e contratos administrativos e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_0259_2020, clausula_decima_terceira_sigilo, 'CLÁUSULA DÉCIMA TERCEIRA – SIGILO DAS INFORMAÇÕES', 'Cabe à CONTRATADA cumprir as seguintes regras de sigilo e assegurar a aceitação e adesão às mesmas por profissionais que integrem ou venham a integrar a sua equipe na prestação do objeto deste Contrato, as quais perdurarão, inclusive, após a cessação do vínculo contratual e da prestação do serviço:  I. cumprir as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES, necessárias para assegurar a integridade e o sigilo das informações;  II. não acessar informações sigilosas do BNDES, salvo quando previamente autorizado por escrito; III. sempre que tiver acesso às informações mencionadas no Inciso anterior: a) manter sigilo dessas informações, não podendo copiá-las, reproduzi-las, retê-las ou praticar qualquer outra forma de uso que não seja imprescindível para a adequada prestação do objeto deste Contrato; b) limitar o acesso às informações aos profissionais envolvidos na prestação do serviço objeto deste Contrato, os quais deverão estar cientes da natureza sigilosa das informações e das obrigações e responsabilidades decorrentes do uso dessas informações; e c) informar imediatamente ao BNDES qualquer violação das regras de sigilo ora estabelecidas que tenha ocorrido por sua ação ou omissão, independente da existência de dolo, bem como dos profissionais envolvidos, adotando todas as orientações do BNDES para remediar a violação; IV. entregar ao BNDES, ao término da vigência deste Contrato, todo e qualquer material de propriedade deste, inclusive notas pessoais envolvendo matéria sigilosa e registro de documentos de qualquer natureza que tenham sido criados, usados ou mantidos sob seu controle ou posse, assumindo o compromisso de não utilizar qualquer informação sigilosa a que teve acesso no âmbito deste Contrato; e  V. observar o disposto no Termo de Confidencialidade assinado por seus representantes legais, anexo a este Contrato.').
contract_clause(contrato_ocs_0259_2020, clausula_decima_quarta_obrigacoes_bndes, 'CLÁUSULA DÉCIMA QUARTA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis, vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos à CONTRATADA, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, José Maciel Franco Junior, que atualmente exerce a função de Coordenador de Serviços da ATI/DESET/GINF, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução do serviço, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita à CONTRATADA; IV. fornecer à CONTRATADA, quando solicitado ao Gestor do Contrato, cópia do Código de Ética do Sistema BNDES, da Política de Conduta e Integridade no  âmbito das licitações e contratos administrativos, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; V. colocar à disposição da CONTRATADA todas as informações necessárias à perfeita execução do serviço objeto deste Contrato; e VI. comunicar à CONTRATADA, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares da CONTRATADA, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_0259_2020, clausula_decima_quinta_cessao, 'CLÁUSULA DÉCIMA QUINTA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO', 'É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte da CONTRATADA, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro É vedada a sucessão contratual, salvo nas hipóteses em que a CONTRATADA realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais, previstos no Termo de Referência.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo, por conseguinte, jus ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É admitida a subcontratação da parcela do objeto deste Contrato nos termos do item 20 do Termo de Referência, condicionada à aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal operação.  Parágrafo Quarto  Caso a CONTRATADA opte por subcontratar o objeto deste Contrato, permanecerá como responsável perante o BNDES pela adequada execução do ajuste, sujeitando-se, inclusive, às penalidades previstas neste Contrato, na hipótese de não cumprir as obrigações ora pactuadas, ainda que por culpa da SUBCONTRATADA.  Parágrafo Quinto Aceita, pelo BNDES, a subcontratação, a CONTRATADA deverá apresentar os Termos de Confidencialidade, conforme modelos anexos a este Contrato, assinados pelo representante legal da SUBCONTRATADA.').
contract_clause(contrato_ocs_0259_2020, clausula_decima_sexta_penalidades, 'CLÁUSULA DÉCIMA SEXTA – PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, a CONTRATADA ficará sujeita às seguintes penalidades: I. advertência; II. multa: a) de até 10 % (dez por cento), sobre o valor global do Contrato, além dos ajustes de pagamento previstos no subitem 8.10 do Anexo I - Termo de Referência, conforme previsão constante do citado subitem;  b) até 0,5% (cinco décimos por cento) sobre o valor mensal do Contrato, por dia, em caso de inadimplemento de qualquer obrigação contratual que envolva cumprimento de prazos estabelecidos no Anexo I - Termo de Referência, até o adimplemento da obrigação, exceto aquelas já abrangidas pelos Ajustes de Pagamento. c) até 10% (dez por cento), apurada de acordo com a gravidade da infração, incidente sobre o valor global do CONTRATO, em razão do descumprimento de outras obrigações contratuais não abrangidas pelas alíneas anteriores. III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades indicadas nesta Cláusula somente poderão ser aplicadas após procedimento administrativo, e desde que assegurados o contraditório e a ampla defesa, facultada à CONTRATADA a defesa prévia, no prazo de 10 (dez) dias úteis.  Parágrafo Segundo  Contra a decisão de aplicação de penalidade, a CONTRATADA poderá interpor o recurso cabível, na forma e no prazo previstos no Regulamento de Formalização, Execução e Fiscalização de Contratos Administrativos do Sistema BNDES.  Parágrafo Terceiro A imposição de sanção prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto A multa prevista nesta Cláusula poderá ser aplicada juntamente com as demais penalidades, observando-se o seguinte:  I. O total da multa prevista na alínea “b” do caput desta Cláusula é limitado em 10% (dez por cento) do valor global do Contrato; II. O valor total das multas aplicadas não poderá exceder a 30% (trinta por cento) do valor global de cada Contrato.  Parágrafo Quinto A multa aplicada à CONTRATADA e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ela devidos, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto No caso de uso indevido de informações sigilosas, observar-se-ão, no que couber, os termos da Lei nº 12.527/2011 e do Decreto nº 7.724/2012.  Parágrafo Sétimo No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Oitavo A sanção prevista no Inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_0259_2020, clausula_decima_setima_alteracoes_contratuais, 'CLÁUSULA DÉCIMA SÉTIMA – ALTERAÇÕES CONTRATUAIS O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que: I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.  Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento e os pequenos ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato, que poderão ser formalizados por meio epistolar.', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que: I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.  Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento e os pequenos ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato, que poderão ser formalizados por meio epistolar.').
contract_clause(contrato_ocs_0259_2020, clausula_decima_oitava_extincao_contrato, 'CLÁUSULA DÉCIMA OITAVA – EXTINÇÃO DO CONTRATO O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, convencionando-se, ainda, que é cabível a sua resolução: I. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; III. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo;  IV. quando for decretada a falência da CONTRATADA; V. caso a CONTRATADA perca uma das condições de habilitação exigidas quando da contratação; VI. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VII. caso a CONTRATADA seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  VIII. em função da suspensão do direito de a CONTRATADA licitar ou contratar com o BNDES; IX. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei n.º 12.846/2013, cometido pela CONTRATADA no processo de contratação ou por ocasião da execução contratual; X. em razão da dissolução da CONTRATADA; e XI. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato e oportunidade de defesa, dispensada a necessidade de interpelação judicial.', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, convencionando-se, ainda, que é cabível a sua resolução: I. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; III. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo;  IV. quando for decretada a falência da CONTRATADA; V. caso a CONTRATADA perca uma das condições de habilitação exigidas quando da contratação; VI. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VII. caso a CONTRATADA seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  VIII. em função da suspensão do direito de a CONTRATADA licitar ou contratar com o BNDES; IX. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei n.º 12.846/2013, cometido pela CONTRATADA no processo de contratação ou por ocasião da execução contratual; X. em razão da dissolução da CONTRATADA; e XI. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato e oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_0259_2020, clausula_decima_nona_disposicoes_finais, 'CLÁUSULA DÉCIMA NONA – DISPOSIÇÕES FINAIS Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram este Contrato, o Termo de Referência, a Proposta da CONTRATADA, a Matriz de Riscos, e os Termos de Confidencialidade, respectivamente, Anexos I, II, III e IV ao presente Instrumento, no que com este não colidir, bem como com as disposições legais aplicáveis, observando-se que, ocorrendo conflitos de interpretação entre as disposições contratuais e de seus anexos, prevalecerá o disposto no Contrato e na legislação em vigor.  Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá  renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram este Contrato, o Termo de Referência, a Proposta da CONTRATADA, a Matriz de Riscos, e os Termos de Confidencialidade, respectivamente, Anexos I, II, III e IV ao presente Instrumento, no que com este não colidir, bem como com as disposições legais aplicáveis, observando-se que, ocorrendo conflitos de interpretação entre as disposições contratuais e de seus anexos, prevalecerá o disposto no Contrato e na legislação em vigor.  Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá  renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_0259_2020, clausula_vigesima_foro, 'CLÁUSULA VIGÉSIMA – FORO  É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As folhas deste Contrato são conferidas por Lara Godoy dos S. F. Rodrigues, advogada do BNDES, por autorização do representante legal que o assina.  E, por estarem assim justos e contratados, firmam o presente Instrumento, redigido em 1 (uma) via, juntamente com as testemunhas abaixo.  Reputa-se celebrado o presente Contrato na data em que for registrada a última assinatura dos representantes legais do BNDES.      __________________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES     __________________________________________________________________________ MUNDIVOX TELECOMUNICAÇÕES LTDA.   Testemunhas:    _________________________________ _________________________________ Nome/CPF: Nome/CPF:', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As folhas deste Contrato são conferidas por Lara Godoy dos S. F. Rodrigues, advogada do BNDES, por autorização do representante legal que o assina.  E, por estarem assim justos e contratados, firmam o presente Instrumento, redigido em 1 (uma) via, juntamente com as testemunhas abaixo.  Reputa-se celebrado o presente Contrato na data em que for registrada a última assinatura dos representantes legais do BNDES.      __________________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES     __________________________________________________________________________ MUNDIVOX TELECOMUNICAÇÕES LTDA.   Testemunhas:    _________________________________ _________________________________ Nome/CPF: Nome/CPF:').

% ===== END =====
